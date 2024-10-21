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
        private readonly ILogger<PayOSController> _logger;

        public PayOSController(IConfiguration config, ILogger<PayOSController> logger)
        {
            _config = config;
            _logger = logger;
        private readonly ISubscriptionService _subscriptionService;

        public PayOSController(IConfiguration config, ISubscriptionService subscriptionService)
        {
            _config = config;
            _subscriptionService = subscriptionService;
        }


        [HttpGet]
        public async Task<IActionResult> GetPaymentLinkInformation(int orderCode)
        {
            _logger.LogInformation("Fetching payment link information for order code: {OrderCode}", orderCode);

            try
            PaymentLinkInformation paymentLinkInformation = await payOS.getPaymentLinkInformation(orderCode);

            bool isUpdated = await _subscriptionService.UpdatePaymentAndSubscription(orderCode, paymentLinkInformation.status);

            ResultModel response = new ResultModel
            {
                // Ghi log các thông tin cấu hình
                _logger.LogInformation("Using PayOS ClientID: {ClientId}, ApiKey: {ApiKey}, ChecksumKey: {ChecksumKey}",
                    _config["PayOS:ClientID"],
                    _config["PayOS:ApiKey"],
                    _config["PayOS:ChecksumKey"]);

                PayOS payOS = new PayOS(_config["PayOS:ClientID"], _config["PayOS:ApiKey"], _config["PayOS:ChecksumKey"]);

                // Gọi API để lấy thông tin liên kết thanh toán
                PaymentLinkInformation paymentLinkInformation = await payOS.getPaymentLinkInformation(orderCode);
                // Giả định paymentLinkInformation là một đối tượng của PaymentLinkInformation
                _logger.LogInformation("Payment Link ID: {id}", paymentLinkInformation.id);
                _logger.LogInformation("Order Code: {orderCode}", paymentLinkInformation.orderCode);
                _logger.LogInformation("Total Amount: {amount}", paymentLinkInformation.amount);
                _logger.LogInformation("Amount Paid: {amountPaid}", paymentLinkInformation.amountPaid);
                _logger.LogInformation("Amount Remaining: {amountRemaining}", paymentLinkInformation.amountRemaining);
                _logger.LogInformation("Status: {status}", paymentLinkInformation.status);
                _logger.LogInformation("Created At: {createdAt}", paymentLinkInformation.createdAt);
                _logger.LogInformation("Canceled At: {canceledAt}", paymentLinkInformation.canceledAt);
                _logger.LogInformation("Cancellation Reason: {cancellationReason}", paymentLinkInformation.cancellationReason);


                ResultModel response = new ResultModel
                {
                    IsSuccess = true,
                    Code = (int)HttpStatusCode.OK,
                    Message = "Get payment link information successfully",
                    Data = paymentLinkInformation
                };

                return StatusCode(response.Code, response);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while fetching payment link information for order code: {OrderCode}", orderCode);

                ResultModel response = new ResultModel
                {
                    IsSuccess = false,
                    Code = (int)HttpStatusCode.InternalServerError,
                    Message = "An error occurred while fetching payment link information",
                    Data = null
                };

                return StatusCode(response.Code, response);
            }
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