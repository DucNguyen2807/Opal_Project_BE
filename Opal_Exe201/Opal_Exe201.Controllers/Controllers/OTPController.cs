using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Opal_Exe201.Data.DTOs.OTPDTOS;
using Opal_Exe201.Service.Services.OTPService;

namespace Opal_Exe201.Controllers.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OTPController : ControllerBase
    {
        private readonly IOTPService _otpService;

        public OTPController(IOTPService oTPService)
        {
            _otpService = oTPService;
        }

        [HttpPost]
        [Route("send")]
        public async Task<IActionResult> SendOTP(OTPSendEmailRequestModel model)
        {
            await _otpService.CreateOTPCodeForEmail(model);
            return Ok();
        }

        [HttpPost]
        [Route("verify")]
        public async Task<IActionResult> VerifyOTP(OTPVerifyRequestModel model)
        {
            await _otpService.VerifyOTP(model);
            return Ok();
        }
    }
}
