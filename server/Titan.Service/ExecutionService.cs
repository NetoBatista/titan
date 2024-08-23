using SimpleAutoMapper;
using Titan.Domain.Constant;
using Titan.Domain.DTO.Execution;
using Titan.Domain.Entity;
using Titan.Domain.Interface.Interface;
using Titan.Domain.Interface.Service;

namespace Titan.Service
{
    public class ExecutionService : IExecutionService
    {
        private readonly IExecutionRepository _executionRepository;
        private readonly IEventRepository _eventRepository;
        public ExecutionService(IExecutionRepository executionRepository, IEventRepository eventRepository)
        {
            _executionRepository = executionRepository;
            _eventRepository = eventRepository;
        }

        public async Task<ExecutionResponseDTO?> Create(ExecutionRequestDTO request)
        {
            var itsTimeExecution = await _eventRepository.ItsTimeToExecute(request.EventId);
            if (!itsTimeExecution)
            {
                return null;
            }
            await _executionRepository.UpdateOldsExecutionsToFail(request.EventId);
            var entity = new Execution
            {
                EventId = request.EventId,
                CreatedAt = DateTime.UtcNow,
                Step = ExecutionStepConstant.Created,
            };
            var response = await _executionRepository.Create(entity);
            return AutoMapper.Map<ExecutionResponseDTO>(response);
        }

        public async Task<List<ExecutionResponseDTO>?> Get()
        {
            var response = await _executionRepository.Get();
            return AutoMapper.Map<List<ExecutionResponseDTO>>(response);
        }

        public Task UpdateStep(ExecutionUpdateStepDTO request)
        {
            var entity = AutoMapper.Map<Execution>(request);
            return _executionRepository.UpdateStep(entity!);
        }
    }
}
