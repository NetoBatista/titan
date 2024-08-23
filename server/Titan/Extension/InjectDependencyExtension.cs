using Microsoft.EntityFrameworkCore;
using Titan.Domain.Entity;
using Titan.Domain.Interface.Interface;
using Titan.Domain.Interface.Service;
using Titan.Repository;
using Titan.Service;

namespace Titan.Extension
{
    public static class InjectDependencyExtension
    {
        public static void InjectDependences(this IServiceCollection services)
        {
            services.InjectDataBase();
            services.InjectService();
            services.InjectRepository();
        }

        private static void InjectDataBase(this IServiceCollection services)
        {
            var connectionString = Environment.GetEnvironmentVariable("CONNECTION_STRING");
            if (string.IsNullOrEmpty(connectionString))
            {
                connectionString = "Host=localhost;Database=titan;Username=postgres;Password=Senha123!";
            }
            services.AddDbContext<TitanContext>(options =>
            {
                options.UseNpgsql(connectionString!);
                options.UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);
            }, ServiceLifetime.Transient);
        }


        private static void InjectService(this IServiceCollection services)
        {
            services.AddTransient<IEventService, EventService>();
            services.AddTransient<IExecutionService, ExecutionService>();
            services.AddTransient<IMigrationService, MigrationService>();

            services.AddHostedService<HostedService>();
        }

        private static void InjectRepository(this IServiceCollection services)
        {
            services.AddTransient<IEventRepository, EventRepository>();
            services.AddTransient<IExecutionRepository, ExecutionRepository>();
            services.AddTransient<IMigrationRepository, MigrationRepository>();
        }
    }
}
