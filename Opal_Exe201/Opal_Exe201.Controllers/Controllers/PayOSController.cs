using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Net.payOS;
using Net.payOS.Types;
using Opal_Exe201.Data.DTOs.PaymentService;
using Opal_Exe201.Data.Enums.PaymentEnums;
using Opal_Exe201.Data.Enums.SubscriptionEnums;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Services.SubscriptionServices;
using System.Net;

namespace Opal_Exe201.Controllers.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PayOSController : ControllerBase
    {
        private readonly IConfiguration _config;
        private readonly ISubscriptionService _subscriptionService;

        public PayOSController(IConfiguration config, ISubscriptionService subscriptionService)
        {
            _config = config;
            _subscriptionService = subscriptionService;
        }

        [HttpGet]
        public async Task<IActionResult> GetPaymentLinkInformation (int orderCode)
        {
            PayOS payOS = new PayOS(_config["PayOS:ClientID"], _config["PayOS:ApiKey"], _config["PayOS:ChecksumKey"]);

            PaymentLinkInformation paymentLinkInformation = await payOS.getPaymentLinkInformation(orderCode);

            bool isUpdated = await _subscriptionService.UpdatePaymentAndSubscription(orderCode, paymentLinkInformation.status);

            ResultModel response = new ResultModel
            {
                IsSuccess = true,
                Code = (int)HttpStatusCode.OK,
                Message = "Get payment link information successfully",
                Data = paymentLinkInformation
            };

            return StatusCode(response.Code, response);
        }

        //[HttpPost("webhook")]
        //public async Task<IActionResult> HandlePaymentWebhook([FromBody] WebhookType webhookBody)
        //{
        //    PayOS payOS = new PayOS(_config["PayOS:ClientID"], _config["PayOS:ApiKey"], _config["PayOS:ChecksumKey"]);
        //    try
        //    {
        //        // Verify webhook data
        //        WebhookData verifiedData = payOS.verifyPaymentWebhookData(webhookBody);
        //        string responseCode = verifiedData.code;
        //        long orderCode = verifiedData.orderCode;
        //        decimal amount = verifiedData.amount;

        //        var payment = await _unitOfWork.PaymentRepository.GetPaymentByOrderCode(orderCode);
        //        if (payment == null)
        //        {
        //            return NotFound(new { message = "Order not found" });
        //        }

        //        // Process payment based on response code
        //        if (responseCode == "00") // Success
        //        {
        //            // Update payment status and related user and subscription
        //            payment.Status = PaymentEnums.Paid.ToString();
        //            payment.PaymentDate = DateTime.Now;
        //            payment.Amount = amount;
        //            await _unitOfWork.PaymentRepository.UpdatePayment(payment);

        //            var user = await _unitOfWork.UsersRepository.GetUserById(payment.UserId);
        //            if (user != null)
        //            {
        //                var subscription = await _unitOfWork.SubscriptionRepository.GetSubscriptionById(payment.SubscriptionId);
        //                var userSub = new UserSub
        //                {
        //                    UserId = user.UserId,
        //                    SubscriptionId = subscription.SubscriptionId,
        //                    StartDate = DateOnly.FromDateTime(DateTime.Now),
        //                    EndDate = DateOnly.FromDateTime(DateTime.Now.AddMonths(subscription.Duration)),
        //                    Status = SubscriptionStatus.Active.ToString(),
        //                    CreatedAt = DateTime.Now
        //                };
        //                await _unitOfWork.UserSubRepository.CreateOrUpdateUserSubAsync(userSub);

        //                user.SubscriptionPlan = "Premium";
        //                await _unitOfWork.UsersRepository.UpdateUser(user);
        //            }

        //            await _unitOfWork.SaveAsync();
        //            return Ok(new { message = "Payment successful" });
        //        }
        //        else // Payment failed
        //        {
        //            payment.Status = PaymentEnums.Failed.ToString();
        //            await _unitOfWork.PaymentRepository.UpdatePayment(payment);
        //            return BadRequest(new { message = "Payment failed", code = responseCode });
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        return StatusCode(500, new { message = "Webhook handling failed", error = ex.Message });
        //    }
        //}
    }
}
