using AutoMapper;
using Opal_Exe201.Data.DTOs.UserDTOs;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Utils;
using Opal_Exe201.Data.Enums.UserEnums;
using Azure.Core;
using Opal_Exe201.Service.Services.EmailServices;
using System.Linq.Expressions;

namespace Opal_Exe201.Service.Services.UserServices
{
    public class UserService : IUserService
    {
        private IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IEmailService _emailService;
        public UserService(IUnitOfWork unitOfWork, IMapper mapper, IEmailService emailService )
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _emailService = emailService;
        }

        public async Task<UserLoginResponseModel> Login(UserLoginRequestModel request)
        {
            var user = (await _unitOfWork.UsersRepository.GetAsync(u => u.Username.Equals(request.Username))).FirstOrDefault();
            if (user == null)
            {
                throw new CustomException("There is no account using this Username!");
            }
            if (!PasswordHasher.VerifyPassword(request.Password, user.Password))
            {
                throw new CustomException("Password incorrect!");
            }
            return new UserLoginResponseModel()
            { 
                UserInfo = new UserInfo
                {
                    Password = user.Password,

                    Email = user.Email,
                    FullName = user.Fullname,
                    Gender = user.Gender,
                    Role = user.Role,
                    PhoneNumber = user.PhoneNumber,
                    SubscriptionPlan = user.SubscriptionPlan,
                    Username = user.Username,
                    UserId = user.UserId.ToString(),

                },
                token = JWTGenerate.GenerateToken(user)

            };
        }
        public async Task<LoadDataUserModel> LoadData(string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");
            var user = (await _unitOfWork.UsersRepository.GetAsync(u => u.UserId.Equals(userId))).FirstOrDefault();
            if (user == null)
            {
                throw new CustomException("Fail to load Data");
            }

            return new LoadDataUserModel()
            {

                Password = user.Password,

                Email = user.Email,
                FullName = user.Fullname,
                Gender = user.Gender,
                PhoneNumber = user.PhoneNumber,
                SubscriptionPlan = user.SubscriptionPlan,
                Username = user.Username,
                UserId = user.UserId.ToString()

            };
        }

        public async System.Threading.Tasks.Task Register(UserRegisterRequestModel request)
        {
            User currentUser = (await _unitOfWork.UsersRepository.GetAsync(u => u.Username.Equals(request.Username))).FirstOrDefault();

            if (currentUser != null)
            {
                throw new CustomException("Username is already used to create account!");
            }
            User phoneUser = (await _unitOfWork.UsersRepository.GetAsync(u => u.PhoneNumber.Equals(request.PhoneNumber))).FirstOrDefault();

            if (phoneUser != null)
            {
                throw new CustomException("Phone number is already used!");
            }


            User newUser = _mapper.Map<User>(request);
            newUser.UserId = Guid.NewGuid().ToString();
            newUser.Role = nameof(RoleEnums.User);
            newUser.Email = request.Username;
            newUser.Fullname = request.Fullname;
            newUser.Gender = "";
            newUser.PhoneNumber = request.PhoneNumber;
            newUser.SubscriptionPlan = nameof(SubscriptionEnum.Free);
            newUser.CreatedAt = DateTime.Now;
            newUser.UpdatedAt = DateTime.Now;

            var firstPassword = PasswordHasher.GenerateRandomPassword();

            var htmlBody = SendEmail.CreateAccountEmail(request.Fullname, request.Username, firstPassword);
            bool sendEmailSuccess = await _emailService.SendEmail(request.Username, "Login Information", htmlBody);
            if (!sendEmailSuccess)
            {
                throw new CustomException("Error in sending email");
            }
            var hash = PasswordHasher.HashPassword(firstPassword);
            newUser.Password = hash;


            await _unitOfWork.UsersRepository.InsertAsync(newUser);

            Seed newSeed = new Seed
            {
                SeedId = Guid.NewGuid().ToString(),
                UserId = newUser.UserId,
                SeedCount = 0,
                PercentGrowth = 0,
                ParrotLevel = 1,
                CreatedAt = DateTime.Now
            };

            await _unitOfWork.SeedRepository.InsertAsync(newSeed);


            UserCustomization userCustomization = new UserCustomization
            {
                UserCustomizationId = Guid.NewGuid().ToString(),
                CustomizationId = 1,
                UserId = newUser.UserId,
            };
            await _unitOfWork.UserCustomizeRepository.InsertAsync(userCustomization);


            UserTheme userTheme = new UserTheme
            {
                UserThemeId = Guid.NewGuid().ToString(),
                ThemeId = 1,
                UserId = newUser.UserId,
            };
            await _unitOfWork.UserThemeRepository.InsertAsync(userTheme);


            _unitOfWork.Save();   
        }

        public async System.Threading.Tasks.Task RegisterTest(UserRegisterRequestTestingModel request)
        {
            User currentUser = (await _unitOfWork.UsersRepository.GetAsync(u => u.Email.Equals(request.Email))).FirstOrDefault();

            if (currentUser != null)
            {
                throw new CustomException("User email existed!");
            }
            User phoneUser = (await _unitOfWork.UsersRepository.GetAsync(u => u.PhoneNumber.Equals(request.PhoneNumber))).FirstOrDefault();

            if (phoneUser != null)
            {
                throw new CustomException("Phone number is already used!");
            }


            User newUser = _mapper.Map<User>(request);
            newUser.Email = request.Email;
            newUser.Username = request.Email;
            newUser.Fullname = request.Fullname;
            newUser.UserId = Guid.NewGuid().ToString();
            newUser.PhoneNumber = request.PhoneNumber;
            newUser.Role = request.Role;
            var  hash = PasswordHasher.HashPassword(request.Password);
            newUser.Password = hash;

            await _unitOfWork.UsersRepository.InsertAsync(newUser);
            _unitOfWork.Save();
        }

        public async Task<GetAllUserResponseModel> GetAllUser(string searchQuery, int pageIndex, int pageSize)
        {
            Expression<Func<User, bool>> searchFilter = u => string.IsNullOrEmpty(searchQuery) ||
                                                               u.Email.Contains(searchQuery) ||
                                                               u.PhoneNumber.Contains(searchQuery) ||
                                                               u.Role.Contains(searchQuery)||
                                                               u.Fullname.Contains(searchQuery)||
                                                               u.SubscriptionPlan.Contains(searchQuery)
                                                               ;

            var users = await _unitOfWork.UsersRepository.GetAsync(searchFilter, pageIndex: pageIndex, pageSize: pageSize);

            var totalUser = await _unitOfWork.UsersRepository.CountAsync(searchFilter);

            var userResponses = _mapper.Map<List<ViewUserResponseModel>>(users);

            return new GetAllUserResponseModel
            {
                Users = userResponses,
                TotalUser = totalUser
            };
        }




        public async System.Threading.Tasks.Task ResetPassword(UserResetPasswordRequestModel request)
        {
            var user = (await _unitOfWork.UsersRepository.GetAsync(u => u.Email.Equals(request.Email))).FirstOrDefault();
            if (user == null)
            {
                throw new CustomException("There is no account using this email!");
            }

            if (!request.NewPassword.Equals(request.ConfirmPassword))
            {
                throw new CustomException("Password and comfirm password must match");
            }
            user.Password = PasswordHasher.HashPassword(request.NewPassword);
            _unitOfWork.UsersRepository.Update(user);
            _unitOfWork.Save();

        }
        public async System.Threading.Tasks.Task ChangePassword(UserChangePasswordRequestModel model, string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");
            var user = (await _unitOfWork.UsersRepository.GetAsync(u => u.UserId.Equals(userId))).FirstOrDefault();

            if (user == null)
            {
                throw new CustomException("There is no account using this email!");
            }

            if (!PasswordHasher.VerifyPassword(model.OldPassword, user.Password))
            {
                throw new CustomException("Password incorrect!");
            }

            if (!model.NewPassword.Equals(model.ConfirmPassword))
            {
                throw new CustomException("Password and comfirm password must match");
            }

            if (PasswordHasher.VerifyPassword(model.NewPassword, user.Password))
            {
                throw new CustomException("New password must not match old password");
            }

            user.Password = PasswordHasher.HashPassword(model.NewPassword);
            _unitOfWork.UsersRepository.Update(user);
            _unitOfWork.Save();

        }



        public async System.Threading.Tasks.Task UpdateUser(UpdateByUserModel request, string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");
            var user = (await _unitOfWork.UsersRepository.GetAsync(u => u.UserId.Equals(userId))).FirstOrDefault();
            if (user == null)
            {            
                throw new CustomException("User not found");
            }
            if (!string.IsNullOrEmpty(request.Fullname))
            {
                user.Fullname = request.Fullname;
            }
            if (!string.IsNullOrEmpty(request.PhoneNumber) && !user.PhoneNumber.Equals(request.PhoneNumber))
            {
                var existingPhoneUser = (await _unitOfWork.UsersRepository.GetAsync(u => u.PhoneNumber.Equals(request.PhoneNumber))).FirstOrDefault();
                if (existingPhoneUser != null)
                {
                    throw new CustomException("Phone number is already used!");
                }
                user.PhoneNumber = request.PhoneNumber;
            }
            if (!string.IsNullOrEmpty(request.Email))
            {
                user.Email = request.Email;
            }
            if (!string.IsNullOrEmpty(request.Gender))
            {
                user.Gender = request.Gender;
            }

            await _unitOfWork.UsersRepository.UpdateAsync(userId, user);
            _unitOfWork.Save();
        }

        public async System.Threading.Tasks.Task UpdateUserForAdmin(AdminUpdateUserResponseModel request, string id)
        {

            var user = await _unitOfWork.UsersRepository.GetByIDAsync(id);


            if (!string.IsNullOrEmpty(request.PhoneNumber) && !user.PhoneNumber.Equals(request.PhoneNumber))
            {
                var existingPhoneUser = (await _unitOfWork.UsersRepository.GetAsync(u => u.PhoneNumber.Equals(request.PhoneNumber))).FirstOrDefault();
                if (existingPhoneUser != null)
                {
                    throw new CustomException("Phone number is already used!");
                }
                user.PhoneNumber = request.PhoneNumber;
            }

            if (!string.IsNullOrEmpty(request.Fullname))
            {
                user.Fullname = request.Fullname;
            }

            if (!string.IsNullOrEmpty(request.PhoneNumber))
            {
                user.PhoneNumber = request.PhoneNumber;
            }

             _unitOfWork.UsersRepository.Update(user);
            _unitOfWork.Save();
        }
    }
}
