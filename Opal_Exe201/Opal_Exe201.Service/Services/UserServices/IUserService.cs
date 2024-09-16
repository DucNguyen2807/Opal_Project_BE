using Opal_Exe201.Data.DTOs.UserDTOs;

namespace Opal_Exe201.Service.Services.UserServices
{
    public interface IUserService
    {
        Task<UserLoginResponseModel> Login(UserLoginRequestModel request);
        Task Register(UserRegisterRequestModel request);
        Task ResetPassword(UserResetPasswordRequestModel request);
        Task ChangePassword(UserChangePasswordRequestModel model, string token);
    }
}
