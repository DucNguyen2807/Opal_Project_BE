using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Opal_Exe201.Service.Services.PaymentServices;
using Opal_Exe201.Service.Services.UserServices;

namespace Opal_Exe201.Controllers.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentController : ControllerBase
    {
        private readonly IPaymentService _paymentService;

        public PaymentController(IPaymentService paymentService)
        {
            _paymentService = paymentService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllPayment()
        {

            var payment = await _paymentService.GetAllPayment();
            return Ok(payment);
        }
        [HttpGet]
        [Route("order-date")]
        public async Task<IActionResult> GetAllPaymentByOrderDate(int pageIndex, int pageSize, string searchQuery = null)
        {

            var payment = await _paymentService.GetAllPaymentOrderDate(searchQuery, pageIndex, pageSize);
            return Ok(payment);
        }
    }
}
