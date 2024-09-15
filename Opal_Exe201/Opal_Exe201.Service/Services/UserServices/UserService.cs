using Opal_Exe201.Data.DTOs.UserDTOs;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Utils;

namespace Opal_Exe201.Service.Services.UserServices
{
    public class UserService : IUserService
    {
        private IUnitOfWork _unitOfWork;
        public UserService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<UserLoginResponseModel> Login(UserLoginRequestModel request)
        {
            var user = (await _unitOfWork.UsersRepository.GetAsync(u => u.Email.Equals(request.Email))).FirstOrDefault();
            if (user == null)
            {
                throw new CustomException("There is no account using this email!");
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


    }
}
