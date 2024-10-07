﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Opal_Exe201.Service.Services.TaskServices;
using Opal_Exe201.Data.DTOs.SeedDTOS;
using Opal_Exe201.Service.Services.SeedServices;
using Microsoft.AspNetCore.Authorization;

namespace Opal_Exe201.Controllers.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FeedController : ControllerBase
    {
        private readonly ISeedService _seedService;

        public FeedController(ISeedService seedService)
        {
            _seedService = seedService;
        }

        /// <summary>
        /// Lấy thông tin Parrot hiện tại của người dùng.
        /// </summary>
        /// <returns>Thông tin Parrot</returns>
        [HttpGet]
        [Route("view-parrot")]
        public async Task<IActionResult> ViewParrot()
        {
            try
            {
                var token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
                var parrotInfo = await _seedService.GetParrotInfoAsync(token);
                return Ok(parrotInfo);
            }
            catch (InvalidOperationException ex)
            {
                return NotFound(new { message = ex.Message });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception)
            {
                return StatusCode(500, new { message = "An unexpected error occurred." });
            }
        }

        /// <summary>
        /// Feed the parrot to increase seed count and potentially level up.
        /// </summary>
        /// <param name="feedRequest">Details of the feed action.</param>
        /// <returns>Updated seed information.</returns>
        [HttpPost]
        [Route("feed-parrot")]
        public async Task<IActionResult> FeedParrot([FromBody] FeedingRequestModel feedRequest)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var token = Request.Headers["Authorization"].ToString().Replace("Bearer ", "");

            try
            {
                var response = await _seedService.FeedParrotAsync(feedRequest, token);
                return Ok(response);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
            catch
            {
                return StatusCode(500, new { message = "An error occurred while feeding the parrot." });
            }
        }
    }
}
