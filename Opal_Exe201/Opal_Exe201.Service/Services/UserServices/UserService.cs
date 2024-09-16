using AutoMapper;
using Opal_Exe201.Data.DTOs.UserDTOs;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Utils;
using Opal_Exe201.Data.Enums.UserEnums;

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
            newUser.Email = "";
            newUser.PhoneNumber = "";
            newUser.SubscriptionPlan = nameof(SubscriptionEnum.Free);
            newUser.CreatedAt = DateTime.Now;
            newUser.UpdatedAt = DateTime.Now;
            var firstPassword = request.Password;

            newUser.Password = PasswordHasher.HashPassword(request.Password);

            await _unitOfWork.UsersRepository.InsertAsync(newUser);
            _unitOfWork.Save();
        }


    }
}
