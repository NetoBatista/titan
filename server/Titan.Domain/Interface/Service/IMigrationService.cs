namespace Titan.Domain.Interface.Service
{
    public interface IMigrationService
    {
        Task<IEnumerable<string>> Get();
        Task Execute();
    }
}
