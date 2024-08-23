namespace Titan.Domain.Entity
{
    public partial class Event
    {
        public Guid Id { get; set; }

        public string Name { get; set; } = null!;

        public string Url { get; set; } = null!;

        public int Interval { get; set; }

        public string Method { get; set; } = null!;

        public virtual ICollection<Execution> ExecutionNavigation { get; set; } = [];
    }
}
