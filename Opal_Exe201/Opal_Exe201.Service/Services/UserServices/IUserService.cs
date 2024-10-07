using Opal_Exe201.Data.DTOs.UserDTOs;

namespace Opal_Exe201.Service.Services.UserServices
{
    public interface IUserService
    {
        Task<UserLoginResponseModel> Login(UserLoginRequestModel request);
        Task<LoadDataUserModel> LoadData(string token);
        Task Register(UserRegisterRequestModel request);
        Task ResetPassword(UserResetPasswordRequestModel request);
        Task UpdateUser(UpdateByUserModel request, string token);
        Task<GetAllUserResponseModel> GetAllUser(string searchQuery, int pageIndex, int pageSize);
        System.Threading.Tasks.Task RegisterTest(UserRegisterRequestTestingModel request);
        Task ChangePassword(UserChangePasswordRequestModel model, string token);
        System.Threading.Tasks.Task UpdateUserForAdmin(AdminUpdateUserResponseModel request, string id);
    }
}
