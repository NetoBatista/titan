namespace Titan.Domain.DTO.Execution
{
    public class ExecutionResponseDTO
    {
        public Guid Id { get; set; }

        public Guid EventId { get; set; }

        public DateTime CreatedAt { get; set; }

        public string Step { get; set; } = null!;
    }
}
