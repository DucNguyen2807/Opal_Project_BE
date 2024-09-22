using AutoMapper;
using Opal_Exe201.Data.DTOs.UserDTOs;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Utils;
using Opal_Exe201.Data.Enums.UserEnums;
using Azure.Core;

namespace Opal_Exe201.Service.Services.UserServices
{
    public class UserService : IUserService
    {
        private IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;

        public UserService(IUnitOfWork unitOfWork, IMapper mapper )
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
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
                    Username = user.Username,
                    UserId = user.UserId.ToString(),

                },
                token = JWTGenerate.GenerateToken(user)

            };
        }

        public async System.Threading.Tasks.Task Register(UserRegisterRequestModel request)
        {
            User currentUser = (await _unitOfWork.UsersRepository.GetAsync(u => u.Username.Equals(request.Username))).FirstOrDefault();

            if (currentUser != null)
            {
                throw new CustomException("Username is already used to create account!");
            }

            User newUser = _mapper.Map<User>(request);
            newUser.UserId = Guid.NewGuid().ToString();
            newUser.Role = nameof(RoleEnums.User);
            newUser.Email = request.Username;
            newUser.Fullname = "";
            newUser.Gender = "";
            newUser.PhoneNumber = "";
            newUser.SubscriptionPlan = nameof(SubscriptionEnum.Free);
            newUser.CreatedAt = DateTime.Now;
            newUser.UpdatedAt = DateTime.Now;
            var firstPassword = request.Password;

            newUser.Password = PasswordHasher.HashPassword(request.Password);

            await _unitOfWork.UsersRepository.InsertAsync(newUser);
            _unitOfWork.Save();
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
            var userId = JWTGenerate.DecodeToken(token, "userId");
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

        public async System.Threading.Tasks.Task UpdateUser(UpdateByUserModel request, string id)
        {
            var user = (await _unitOfWork.UsersRepository.GetAsync(u => u.UserId.Equals(id))).FirstOrDefault();
            if (user == null)
            {
                throw new CustomException("User not found");
            }
            if (!string.IsNullOrEmpty(request.Fullname))
            {
                user.Fullname = request.Fullname;
            }
            if (!string.IsNullOrEmpty(request.PhoneNumber))
            {
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

            await _unitOfWork.UsersRepository.UpdateAsync(id, user);
            _unitOfWork.Save();
        }

    }
}
