using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Titan.Domain.Entity;

namespace Titan.Domain.Extension
{
    public static class MigrationExtension
    {
        public static void ExecuteMigrations(this IServiceCollection services)
        {
            var provider = services.BuildServiceProvider();
            var migrationService = provider.GetService<TitanContext>();
            if (migrationService == null)
            {
                return;
            }
            var pendingMigrations = migrationService.Database.GetPendingMigrations();
            if (pendingMigrations.Any())
            {
                migrationService.Database.Migrate();
            }
        }
    }
}
