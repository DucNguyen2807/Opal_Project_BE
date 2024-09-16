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

        [HttpPost]
        [Route("login")]
        public async Task<IActionResult> Login(UserLoginRequestModel request)
        {
            var user = await _userService.Login(request);
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

    }
}