using Titan.Domain.Entity;

namespace Titan.Domain.Interface.Interface
{
    public interface IExecutionRepository
    {
        Task<Execution> Create(Execution entity);
        Task UpdateOldsExecutionsToFail(Guid eventId);
        Task UpdateStep(Execution entity);
        Task<List<Execution>> Get();
    }
}
