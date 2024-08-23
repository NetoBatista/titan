namespace Titan.Domain.Interface.Interface
{
    public interface IMigrationRepository
    {
        Task<IEnumerable<string>> Get();
        Task Execute();
    }
}
