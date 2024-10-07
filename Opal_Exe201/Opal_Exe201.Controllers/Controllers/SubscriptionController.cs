using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Opal_Exe201.Data.Enums.SubscriptionEnums;
using Opal_Exe201.Service.Services.PaymentServices;
using Opal_Exe201.Service.Services.SubscriptionServices;

namespace Opal_Exe201.Controllers.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SubscriptionController : ControllerBase
    {
        private readonly ISubscriptionService _subscriptionService;

        public SubscriptionController(ISubscriptionService subscriptionService)
        {
            _subscriptionService = subscriptionService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllSubscription(int pageIndex, int pageSize, string searchQuery = null)
        {

            var subscription = await _subscriptionService.GetAllSubscription(searchQuery, pageIndex, pageSize);
            return Ok(subscription);
        }


        [HttpPatch("{subscriptionId}")]
        public async Task<IActionResult> ToggleSubscriptionStatus(string subscriptionId)
        {
            try
            {
                var result = await _subscriptionService.ToggleSubscriptionStatus(subscriptionId);
                return Ok(new { success = result });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
        [HttpPut]
        [Route("update/{id}")]
        public async Task<IActionResult> UpdateCoinPacks(SubscriptionUpdateRequestModel requestModel, string id)
        {
            await _subscriptionService.UpdateCoinPack(requestModel, id);
            return Ok("Subscription update successfully");
        }
    }
}
