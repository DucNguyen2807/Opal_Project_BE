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
        public async Task<IActionResult> Login([FromBody] UserLoginRequestModel request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                var response = await _userService.Login(request);
                return Ok(response);
            }
            catch (CustomException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }


    }
}