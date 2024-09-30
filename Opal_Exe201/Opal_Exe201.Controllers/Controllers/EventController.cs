using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Opal_Exe201.Data.DTOs.EventDTOS;
using Opal_Exe201.Service.Services.EventServices;

namespace Opal_Exe201.Controllers.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EventsController : ControllerBase
    {
        private readonly IEventService _eventService;

        public EventsController(IEventService eventService)
        {
            _eventService = eventService;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<EventResponse>>> GetAllEventsByDateAsync(DateTime date)
        {
            string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
            var events = await _eventService.GetAllEventsByDateAsync(date, token);
            return Ok(events);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<EventResponse>> GetEventById(string id)
        {
            string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
            var eventResponse = await _eventService.GetEventByIdAsync(id, token);
            if (eventResponse == null)
            {
                return NotFound();
            }

            return Ok(eventResponse);
        }

        [HttpPost]
        [Route("create-event")]
        public async Task<ActionResult<EventResponse>> CreateEvent(EventCreateRequest eventRequest)
        {
            string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
            var createdEvent = await _eventService.CreateEventAsync(eventRequest, token);
            return CreatedAtAction(nameof(GetEventById), new { id = createdEvent.EventId }, createdEvent);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateEvent(string id, [FromBody] EventCreateRequest eventRequest)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
            var result = await _eventService.UpdateEventAsync(id, eventRequest, token);

            if (!result)
            {
                return NotFound();
            }

            return NoContent();
        }

        [HttpDelete]
        [Route("delete-event/{id}")]
        public async Task<IActionResult> DeleteEvent(string id)
        {
            string token = Request.Headers["Authorization"].ToString().Split(" ")[1];
            var result = await _eventService.DeleteEventAsync(id, token);
            if (!result)
            {
                return NotFound();
            }

            return NoContent();
        }
    }
}
