using SimpleAutoMapper;
using Titan.Domain.DTO.Event;
using Titan.Domain.Entity;
using Titan.Domain.Interface.Interface;
using Titan.Domain.Interface.Service;

namespace Titan.Service
{
    public class EventService : IEventService
    {
        private readonly IEventRepository _eventRepository;
        public EventService(IEventRepository eventRepository)
        {
            _eventRepository = eventRepository;
        }
        public async Task<EventResponseDTO?> Create(EventRequestDTO request)
        {
            var entity = AutoMapper.Map<Event>(request);
            var response = await _eventRepository.Create(entity!);
            return AutoMapper.Map<EventResponseDTO>(response);
        }

        public Task Delete(Guid id)
        {
            var entity = new Event { Id = id };
            return _eventRepository.Delete(entity);
        }

        public async Task<List<EventResponseDTO>?> Get()
        {
            var response = await _eventRepository.Get();
            return AutoMapper.Map<List<EventResponseDTO>>(response);
        }

        public Task<bool> ItsTimeToExecute(Guid eventId)
        {
            return _eventRepository.ItsTimeToExecute(eventId);
        }

        public async Task<EventResponseDTO?> Update(EventUpdateRequestDTO request)
        {
            var entity = AutoMapper.Map<Event>(request);
            var response = await _eventRepository.Update(entity!);
            return AutoMapper.Map<EventResponseDTO>(response);
        }
    }
}
