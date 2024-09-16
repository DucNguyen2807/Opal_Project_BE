using Opal_Exe201.Data.DTOs.OTPDTOS;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Utils;
using Opal_Exe201.Service.Services.EmailServices;
namespace Opal_Exe201.Service.Services.OTPService
{
    public class OTPService : IOTPService
    {
        private IUnitOfWork _unitOfWork;
        private readonly IEmailService _emailService;


        public OTPService(IUnitOfWork unitOfWork, IEmailService emailService)
        {
            _unitOfWork = unitOfWork;
            _emailService = emailService;

        }
        private string CreateNewOTPCode()
        {
            return new Random().Next(0, 10000).ToString("D4");
        }


        public async System.Threading.Tasks.Task CreateOTPCodeForEmail(OTPSendEmailRequestModel model)
        {
            User currentUser = (await _unitOfWork.UsersRepository.GetAsync(u => u.Email.Equals(model.Email))).FirstOrDefault();

            if (currentUser == null)
            {
                throw new CustomException("There is no account with this email");
            }

            var latestOTPList = await _unitOfWork.OTPCodeRepository.GetAsync(o => o.CreatedBy == currentUser.UserId, o => o.OrderByDescending(o => o.CreatedAt));
            var latestOTP = latestOTPList.FirstOrDefault();
            if (latestOTP != null)
            {
                if ((DateTime.Now - latestOTP.CreatedAt).TotalMinutes < 2)
                {
                    throw new CustomException($"Cannot send new OTP right now, please wait for {(120 - (DateTime.Now - latestOTP.CreatedAt).TotalSeconds).ToString("0.00")} second(s)");
                }
            }

            string newOTP = CreateNewOTPCode();
            var htmlBody = SendEmail.SendingOTPEmail( newOTP, model.Subject.ToLower());
            bool sendEmailSuccess = await _emailService.SendEmail(model.Email, model.Subject, htmlBody);
            if (!sendEmailSuccess)
            {
                throw new CustomException("Error in sending email");
            }
            Otpcode newOTPCode = new Otpcode()
            {
                Id = Guid.NewGuid().ToString(),
                Otp = newOTP,
                CreatedBy = currentUser.UserId,
                CreatedAt = DateTime.Now,
                IsUsed = false,
            };

            _unitOfWork.OTPCodeRepository.InsertAsync(newOTPCode);
            _unitOfWork.Save();
        }

        public async System.Threading.Tasks.Task VerifyOTP(OTPVerifyRequestModel model)
        {
            User currentUser = (await _unitOfWork.UsersRepository.GetAsync(u => u.Email.Equals(model.Email))).FirstOrDefault();

            if (currentUser == null)
            {
                throw new CustomException("There is no account with this email");
            }

            var latestOTPList = await _unitOfWork.OTPCodeRepository.GetAsync(o => o.CreatedBy == currentUser.UserId, o => o.OrderByDescending(o => o.CreatedAt));
            var latestOTP = latestOTPList.FirstOrDefault();

            if (latestOTP != null)
            {
                if ((DateTime.Now - latestOTP.CreatedAt).TotalMinutes > 30 || latestOTP.IsUsed)
                {
                    throw new CustomException("The OTP is already used or expired");
                }

                if (latestOTP.Otp.ToString().Trim().Equals(model.OTP.ToString().Trim()))
                {
                    latestOTP.IsUsed = true;
                }

                else
                {
                    throw new CustomException("The OTP is incorrect");
                }
                Console.WriteLine($"Latest OTP: '{latestOTP.Otp}'");
                Console.WriteLine($"Input OTP: '{model.OTP}'");

                _unitOfWork.OTPCodeRepository.UpdateAsync(latestOTP.Id, latestOTP);
                _unitOfWork.Save();

            }
        }
    }
}