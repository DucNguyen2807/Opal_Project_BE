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
        public async Task<IActionResult> GetAllPayment(int pageIndex, int pageSize, string searchQuery = null)
        {

            var payment = await _paymentService.GetAllPayment(searchQuery, pageIndex, pageSize);
            return Ok(payment);
        }
    }
}
