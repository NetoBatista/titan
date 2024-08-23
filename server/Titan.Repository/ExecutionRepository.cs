using Microsoft.EntityFrameworkCore;
using Titan.Domain.Constant;
using Titan.Domain.Entity;
using Titan.Domain.Interface.Interface;

namespace Titan.Repository
{
    public class ExecutionRepository : IExecutionRepository
    {
        private readonly TitanContext _titanContext;
        public ExecutionRepository(TitanContext titanContext)
        {
            _titanContext = titanContext;
        }

        public async Task<Execution> Create(Execution entity)
        {
            entity.CreatedAt = DateTime.UtcNow;
            entity.Step = ExecutionStepConstant.Created;
            _titanContext.Executions.Add(entity);
            await _titanContext.SaveChangesAsync();
            return entity;
        }

        public Task UpdateOldsExecutionsToFail(Guid eventId)
        {
            var entities = _titanContext.Executions.AsNoTracking()
                                                   .Where(x => x.EventId == eventId &&
                                                               (x.Step == ExecutionStepConstant.Created ||
                                                                x.Step == ExecutionStepConstant.InProgress))
                                                   .ToList();
            foreach (var entity in entities)
            {
                entity.Step = ExecutionStepConstant.Fail;
                _titanContext.Executions.Update(entity);
            }
            return _titanContext.SaveChangesAsync();
        }

        public Task UpdateStep(Execution entity)
        {
            var currentEntity = _titanContext.Executions.AsNoTracking().First(x => x.Id == entity.Id);
            currentEntity.Step = entity.Step;
            _titanContext.Executions.Update(currentEntity);
            return _titanContext.SaveChangesAsync();
        }

        public Task<List<Execution>> Get()
        {
            return _titanContext.Executions.OrderByDescending(x => x.CreatedAt).Take(100).ToListAsync();
        }

        public Task<Execution?> GetLastExecution(Guid eventId)
        {
            return _titanContext.Executions.OrderByDescending(x => x.CreatedAt)
                                           .FirstOrDefaultAsync(x => x.EventId == eventId);
        }
    }
}
