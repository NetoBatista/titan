namespace Titan.Domain.Entity
{
    public partial class Execution
    {
        public Guid Id { get; set; }

        public Guid EventId { get; set; }

        public DateTime CreatedAt { get; set; }

        public string Step { get; set; } = null!;

        public virtual Event EventNavigation { get; set; } = null!;
    }
}
