using Microsoft.AspNetCore.Mvc;
using Titan.Domain.DTO.Execution;
using Titan.Domain.Interface.Service;

namespace Titan.Controller
{
    [ApiController]
    [Route("api/[controller]")]
    public class ExecutionController : ControllerBase
    {
        private readonly IExecutionService _executionService;
        public ExecutionController(IExecutionService executionService)
        {
            _executionService = executionService;
        }

        [HttpGet]
        public async Task<ActionResult<List<ExecutionResponseDTO>>> Get()
        {
            var events = await _executionService.Get();
            return Ok(events);
        }

    }
}
