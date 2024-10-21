using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Net.payOS;
using Net.payOS.Types;
using Opal_Exe201.Data.DTOs.PaymentService;
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
        }


        [HttpGet]
        public async Task<IActionResult> GetPaymentLinkInformation(int orderCode)
        {
            _logger.LogInformation("Fetching payment link information for order code: {OrderCode}", orderCode);

            try
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





    }
}