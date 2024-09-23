using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Opal_Exe201.Service.Services.TaskServices;

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

    }
}
