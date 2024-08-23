using Titan.Domain.Entity;

namespace Titan.Domain.Interface.Interface
{
    public interface IEventRepository
    {
        Task<List<Event>> Get();
        Task<Event> Create(Event entity);
        Task Delete(Event entity);
        Task<Event> Update(Event entity);
        Task<bool> ItsTimeToExecute(Guid eventId);
    }
}
