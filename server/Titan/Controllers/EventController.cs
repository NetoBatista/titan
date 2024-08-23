using Microsoft.AspNetCore.Mvc;
using Titan.Domain.DTO.Event;
using Titan.Domain.Interface.Service;

namespace Titan.Controller
{
    [ApiController]
    [Route("api/[controller]")]
    public class EventController : ControllerBase
    {
        private readonly IEventService _eventService;
        public EventController(IEventService eventService)
        {
            _eventService = eventService;
        }

        [HttpPost]
        public async Task<ActionResult<EventResponseDTO>> Create([FromBody] EventRequestDTO request)
        {
            var response = await _eventService.Create(request);
            return Ok(response);
        }

        [HttpGet]
        public async Task<ActionResult<List<EventResponseDTO>>> Get()
        {
            var events = await _eventService.Get();
            return Ok(events);
        }

        [HttpPatch("{eventId}")]
        public async Task<ActionResult<EventResponseDTO>> Update(Guid eventId, [FromBody] EventUpdateRequestDTO request)
        {
            request.Id = eventId;
            var response = await _eventService.Update(request);
            return Ok(response);
        }

        [HttpDelete("{eventId}")]
        public async Task<ActionResult> Delete(Guid eventId)
        {
            await _eventService.Delete(eventId);
            return Ok();
        }
    }
}
