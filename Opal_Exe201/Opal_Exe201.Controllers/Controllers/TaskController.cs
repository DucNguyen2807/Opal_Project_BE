using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Opal_Exe201.Data.DTOs.TaskDTOs;
using Opal_Exe201.Data.DTOs.UserDTOs;
using Opal_Exe201.Service.Services.TaskServices;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace Opal_Exe201.Controllers.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TaskController : ControllerBase
    {
        private readonly ITaskService _taskService;

        public TaskController(ITaskService taskService)
        {
            _taskService = taskService;
        }


        [HttpGet]
        [Route("get-task-by-date")]
        public async Task<IActionResult> GetTasksByDate([FromQuery] DateTime date)
        {
            string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
            var tasks = await _taskService.GetTasksByDateAsync(date, token);

            if (tasks == null)
            {
                return NotFound("No tasks found for the selected date.");
            }

            return Ok(tasks);
        }

        [HttpPut]
        [Route("toggle-task-completion/{taskId}")]
        public async Task<IActionResult> ToggleTaskCompletion(string taskId)
        {
            try
            {
                string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
                bool result = await _taskService.ToggleTaskCompletionAsync(taskId, token);
                if (!result)
                {
                    return NotFound("Task not found or user does not have permission.");
                }
                return Ok("Task completion status updated successfully.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }
        [HttpPost]
        [Route("create-task")]
        public async Task<IActionResult> Register(TaskCreateRequestModel request)
        {
            string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
            await _taskService.InsertTaskAsync(request, token);
            return Ok("Create successfully!");
        }
        [HttpDelete]
        [Route("delete-task/{taskId}")]
        public async Task<IActionResult> DeleteTask(string taskId)
        {
            try
            {
                string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
                bool result = await _taskService.DeleteTaskAsync(taskId, token);

                if (!result)
                {
                    return NotFound("Task not found or user does not have permission.");
                }

                return Ok("Task deleted successfully.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"An error occurred: {ex.Message}");
            }
        }

    }
}

