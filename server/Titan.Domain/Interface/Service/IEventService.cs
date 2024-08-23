using Titan.Domain.DTO.Event;

namespace Titan.Domain.Interface.Service
{
    public interface IEventService
    {
        Task<EventResponseDTO?> Update(EventUpdateRequestDTO entity);
        Task<List<EventResponseDTO>?> Get();
        Task<EventResponseDTO?> Create(EventRequestDTO entity);
        Task Delete(Guid id);
        Task<bool> ItsTimeToExecute(Guid eventId);
    }
}
