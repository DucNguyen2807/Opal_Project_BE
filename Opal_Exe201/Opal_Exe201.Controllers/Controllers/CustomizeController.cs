using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Opal_Exe201.Data.Repositories.UserCustomizeRepositories;
using Opal_Exe201.Service.Services.CustomizeServices;
namespace Opal_Exe201.Controllers.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomizeController : ControllerBase
    {
        private readonly ICustomizeService _customize;

        public CustomizeController(ICustomizeService customizeService) { 
        _customize = customizeService;
        
        }
        [HttpGet]
        [Route("get-customize-by-user")]
        public async Task<IActionResult> GetCustomizeByUser()
        {
            string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
            var customize = await _customize.GetCustomizeByUserAsync(token);
            return Ok(customize);
        }
        [HttpGet]
        [Route("get-customize")]
        public async Task<IActionResult> GetCustomize()
        {
            var tasks = await _customize.GetCustomizeAsync();
            return Ok(tasks);
        }

        [HttpPut]
        [Route("update-customize-by-me/{customizeId}")]
        public async Task<IActionResult> UpdateUserCustomize(int customizeId)
        {
            try
            {
                string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
                bool result = await _customize.UpdateUserCustomizationAsync(customizeId, token);
                if (!result)
                {
                    return NotFound("Customize not found or user does not have permission.");
                }
                return Ok("Customize completion status updated successfully.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }
    }
}
