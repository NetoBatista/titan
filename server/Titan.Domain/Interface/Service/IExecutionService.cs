using Titan.Domain.DTO.Execution;

namespace Titan.Domain.Interface.Service
{
    public interface IExecutionService
    {
        Task<ExecutionResponseDTO?> Create(ExecutionRequestDTO request);
        Task UpdateStep(ExecutionUpdateStepDTO entity);
        Task<List<ExecutionResponseDTO>?> Get();
    }
}
