using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Opal_Exe201.Data.DTOs.DeviceTokenDTOS;
using Opal_Exe201.Service.Services.NotificationServices;

namespace Opal_Exe201.Controllers.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NotificationController : ControllerBase
    {
        private readonly IDeviceTokenService _devicetokenService;

        public NotificationController(IDeviceTokenService devicetokenService)
        {
            _devicetokenService = devicetokenService;
        }

        [HttpPost("save_device_token")]
        public async Task<IActionResult> SaveDeviceToken([FromBody] DeviceTokenRequestModel model)
        {
            // Extract the token from the Authorization header
            var token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");

            if (string.IsNullOrWhiteSpace(token))
            {
                return Unauthorized("Authorization token is missing.");
            }

            try
            {
                var result = await _devicetokenService.SaveDeviceTokenAsync(token, model.Devicetoken);

                if (!result)
                {
                    return NotFound("User not found or device token could not be updated.");
                }

                return Ok("Device token saved successfully.");
            }
            catch (ArgumentException ex)
            {
                return BadRequest(ex.Message);
            }
            catch (KeyNotFoundException ex)
            {
                return NotFound(ex.Message);
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, "An error occurred while saving the device token.");
            }
        }
    }
}
