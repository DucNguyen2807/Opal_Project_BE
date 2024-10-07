using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Opal_Exe201.Data.DTOs.UserDTOs;
using Opal_Exe201.Service.Services.UserServices;
using Opal_Exe201.Service.Utils;

namespace Opal_Exe201.Controllers.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;

        public UserController(IUserService userService)
        {
            _userService = userService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllUser(int pageIndex, int pageSize, string searchQuery = null)
        {

            var users = await _userService.GetAllUser(searchQuery, pageIndex, pageSize);
            return Ok(users);
        }

        [HttpPost]
        [Route("register-test")]
        public async Task<IActionResult> RegisterTest(UserRegisterRequestTestingModel request)
        {
            await _userService.RegisterTest(request);
            return Ok("Register successfully!");
        }

        [HttpPost]
        [Route("login")]
        public async Task<IActionResult> Login(UserLoginRequestModel request)
        {
            var user = await _userService.Login(request);
            return Ok(user);
        }

        [HttpGet]
        [Route("load-data")]
        public async Task<IActionResult> LoadData()
        {
            string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
            var user = await _userService.LoadData(token);
            return Ok(user);
        }
        [HttpPost]
        [Route("register")]
        public async Task<IActionResult> Register(UserRegisterRequestModel request)
        {
            await _userService.Register(request);
            return Ok("Register successfully!");
        }
        [HttpPost]
        [Route("password/reset")]
        public async Task<IActionResult> ResetPassword(UserResetPasswordRequestModel request)
        {
            await _userService.ResetPassword(request);
            return Ok();
        }
        [HttpPut]
        [Route("user/update")]
        public async Task<IActionResult> UpdateUser([FromBody] UpdateByUserModel request)
        {
            string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
            await _userService.UpdateUser(request, token);
            return Ok("User updated successfully!");
        }
        [HttpPut]
        [Route("password/change")]
        public async Task<IActionResult> ChangePassword([FromBody] UserChangePasswordRequestModel model)
        {
            string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
            await _userService.ChangePassword(model, token);
            return Ok("Password changed successfully!");
        }

        [HttpPut]
        [Route("admin/update")]
        //[Authorize(Roles = "Admin")]
        public async Task<IActionResult> UpdateUserForAdmin([FromBody] AdminUpdateUserResponseModel request, string id)
        {

            await _userService.UpdateUserForAdmin(request, id);
            return Ok("User updated successfully!");
        }

    }
}