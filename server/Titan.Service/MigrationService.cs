using System.Diagnostics.CodeAnalysis;
using Titan.Domain.Interface.Interface;
using Titan.Domain.Interface.Service;

namespace Titan.Service
{
    [ExcludeFromCodeCoverage]
    public class MigrationService : IMigrationService
    {
        private readonly IMigrationRepository _migrationRepository;

        public MigrationService(IMigrationRepository migrationRepository)
        {
            _migrationRepository = migrationRepository;
        }

        public Task Execute() => _migrationRepository.Execute();

        public Task<IEnumerable<string>> Get() => _migrationRepository.Get();
    }
}
