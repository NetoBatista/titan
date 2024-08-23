using Microsoft.EntityFrameworkCore;
using System.Diagnostics.CodeAnalysis;
using Titan.Domain.Entity;
using Titan.Domain.Interface.Interface;

namespace Titan.Repository
{
    [ExcludeFromCodeCoverage]
    public class MigrationRepository : IMigrationRepository
    {
        private readonly TitanContext _context;

        public MigrationRepository(TitanContext context)
        {
            _context = context;
        }

        public Task Execute()
        {
            return _context.Database.MigrateAsync();
        }

        public Task<IEnumerable<string>> Get()
        {
            return _context.Database.GetPendingMigrationsAsync();
        }
    }
}
