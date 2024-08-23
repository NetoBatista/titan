using Microsoft.EntityFrameworkCore;

namespace Titan.Domain.Entity
{
    public partial class TitanContext : DbContext
    {
        public TitanContext()
        {
        }

        public TitanContext(DbContextOptions<TitanContext> options) : base(options)
        {
        }

        public virtual DbSet<Event> Events { get; set; }

        public virtual DbSet<Execution> Executions { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var connectionString = Environment.GetEnvironmentVariable("CONNECTION_STRING");
            if (string.IsNullOrEmpty(connectionString))
            {
                connectionString = "Host=localhost;Database=titan;Username=postgres;Password=Senha123!";
            }
            optionsBuilder.UseNpgsql(connectionString);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Event>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("event_pkey");

                entity.ToTable("event");

                entity.Property(e => e.Id)
                    .HasDefaultValueSql("gen_random_uuid()")
                    .HasColumnName("id");
                entity.Property(e => e.Interval).HasColumnName("interval");
                entity.Property(e => e.Name)
                    .HasMaxLength(100)
                    .HasColumnName("name");
                entity.Property(e => e.Url)
                    .HasMaxLength(1000)
                    .HasColumnName("url");
                entity.Property(e => e.Method)
                    .HasMaxLength(10)
                    .HasColumnName("method");
            });

            modelBuilder.Entity<Execution>(entity =>
            {
                entity.HasKey(e => e.Id).HasName("execution_pkey");

                entity.ToTable("execution");

                entity.Property(e => e.Id)
                    .HasDefaultValueSql("gen_random_uuid()")
                    .HasColumnName("id");
                entity.Property(e => e.CreatedAt)
                    .HasColumnType("timestamp with time zone")
                    .HasColumnName("createdat");
                entity.Property(e => e.EventId).HasColumnName("eventid");
                entity.Property(e => e.Step)
                    .HasMaxLength(20)
                    .HasColumnName("step");

                entity.HasOne(d => d.EventNavigation)
                    .WithMany(p => p.ExecutionNavigation)
                    .HasForeignKey(d => d.EventId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("execution_eventid_fkey");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);

        public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            var result = await base.SaveChangesAsync(cancellationToken);
            ChangeTracker.Clear();
            return result;
        }
    }
}
