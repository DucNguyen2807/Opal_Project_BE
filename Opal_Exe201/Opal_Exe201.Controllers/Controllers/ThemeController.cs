using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Opal_Exe201.Service.Services.CustomizeServices;
using Opal_Exe201.Service.Services.ThemeServices;

namespace Opal_Exe201.Controllers.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ThemeController : ControllerBase
    {
        private readonly IThemeService _theme;

        public ThemeController(IThemeService themeService)
        {
            _theme = themeService;

        }
        [HttpGet]
        [Route("get-theme-by-user/{userId}")]
        public async Task<IActionResult> GetThemeByUser(string userId)
        {
            var theme = await _theme.GetThemeByUserAsync(userId);
            return Ok(theme);
        }
        [HttpGet]
        [Route("get-theme")]
        public async Task<IActionResult> GetTheme()
        {
            var theme = await _theme.GetThemeAsync();
            return Ok(theme);
        }

        [HttpPut]
        [Route("update-theme-by-me/{themeId}")]
        public async Task<IActionResult> UpdateUserCustomize(int themeId)
        {
            try
            {
                string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
                bool result = await _theme.UpdateUserThemeAsync(themeId, token);
                if (!result)
                {
                    return NotFound("Theme not found or user does not have permission.");
                }
                return Ok("Theme completion status updated successfully.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }
    }
}
