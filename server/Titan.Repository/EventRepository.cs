using Microsoft.EntityFrameworkCore;
using Titan.Domain.Constant;
using Titan.Domain.Entity;
using Titan.Domain.Interface.Interface;

namespace Titan.Repository
{
    public class EventRepository : IEventRepository
    {
        private readonly TitanContext _titanContext;
        public EventRepository(TitanContext titanContext)
        {
            _titanContext = titanContext;
        }

        public Task<List<Event>> Get()
        {
            return _titanContext.Events.AsNoTracking().OrderBy(x => x.Name).ToListAsync();
        }

        public async Task<Event> Create(Event entity)
        {
            _titanContext.Events.Add(entity);
            await _titanContext.SaveChangesAsync();
            return entity;
        }

        public Task Delete(Event entity)
        {
            var currentEntity = _titanContext.Events.AsNoTracking()
                                                    .Include(x => x.ExecutionNavigation)
                                                    .First(x => x.Id == entity.Id);
            _titanContext.Events.Remove(currentEntity);
            return _titanContext.SaveChangesAsync();
        }

        public async Task<Event> Update(Event entity)
        {
            var currentEntity = await _titanContext.Events.AsNoTracking().FirstAsync(x => x.Id == entity.Id);
            currentEntity.Name = entity.Name;
            currentEntity.Url = entity.Url;
            currentEntity.Interval = entity.Interval;
            currentEntity.Method = entity.Method;
            _titanContext.Update(currentEntity);
            await _titanContext.SaveChangesAsync();
            return entity;
        }

        public async Task<bool> ItsTimeToExecute(Guid eventId)
        {
            var currentEntity = await _titanContext.Events.AsNoTracking().FirstOrDefaultAsync(x => x.Id == eventId);
            if (currentEntity == null)
            {
                return false;
            }

            var lastExecution = await _titanContext.Executions.AsNoTracking()
                                                              .OrderByDescending(x => x.CreatedAt)
                                                              .FirstOrDefaultAsync(x => x.EventId == eventId &&
                                                                                        (x.Step == ExecutionStepConstant.Success ||
                                                                                        x.Step == ExecutionStepConstant.Fail));

            if (lastExecution != null)
            {
                var nextExecution = lastExecution.CreatedAt.AddSeconds(currentEntity.Interval);
                return DateTime.UtcNow > nextExecution;
            }

            return true;
        }
    }
}
