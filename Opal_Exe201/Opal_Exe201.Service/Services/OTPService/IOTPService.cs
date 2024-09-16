using Opal_Exe201.Data.DTOs.OTPDTOS;
namespace Opal_Exe201.Service.Services.OTPService
{
    public interface IOTPService
    {
        Task CreateOTPCodeForEmail(OTPSendEmailRequestModel model);
        Task VerifyOTP(OTPVerifyRequestModel model);
    }
}
