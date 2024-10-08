﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;
using Titan.Domain.Entity;

#nullable disable

namespace Titan.Domain.Migrations
{
    [DbContext(typeof(TitanContext))]
    partial class TitanContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.8")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("Titan.Domain.Entity.Event", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid")
                        .HasColumnName("id")
                        .HasDefaultValueSql("gen_random_uuid()");

                    b.Property<int>("Interval")
                        .HasColumnType("integer")
                        .HasColumnName("interval");

                    b.Property<string>("Method")
                        .IsRequired()
                        .HasMaxLength(10)
                        .HasColumnType("character varying(10)")
                        .HasColumnName("method");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasMaxLength(100)
                        .HasColumnType("character varying(100)")
                        .HasColumnName("name");

                    b.Property<string>("Url")
                        .IsRequired()
                        .HasMaxLength(1000)
                        .HasColumnType("character varying(1000)")
                        .HasColumnName("url");

                    b.HasKey("Id")
                        .HasName("event_pkey");

                    b.ToTable("event", (string)null);
                });

            modelBuilder.Entity("Titan.Domain.Entity.Execution", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid")
                        .HasColumnName("id")
                        .HasDefaultValueSql("gen_random_uuid()");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("timestamp with time zone")
                        .HasColumnName("createdat");

                    b.Property<Guid>("EventId")
                        .HasColumnType("uuid")
                        .HasColumnName("eventid");

                    b.Property<string>("Step")
                        .IsRequired()
                        .HasMaxLength(20)
                        .HasColumnType("character varying(20)")
                        .HasColumnName("step");

                    b.HasKey("Id")
                        .HasName("execution_pkey");

                    b.HasIndex("EventId");

                    b.ToTable("execution", (string)null);
                });

            modelBuilder.Entity("Titan.Domain.Entity.Execution", b =>
                {
                    b.HasOne("Titan.Domain.Entity.Event", "EventNavigation")
                        .WithMany("ExecutionNavigation")
                        .HasForeignKey("EventId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired()
                        .HasConstraintName("execution_eventid_fkey");

                    b.Navigation("EventNavigation");
                });

            modelBuilder.Entity("Titan.Domain.Entity.Event", b =>
                {
                    b.Navigation("ExecutionNavigation");
                });
#pragma warning restore 612, 618
        }
    }
}
