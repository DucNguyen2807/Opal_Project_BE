using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace Opal_Exe201.Data.Models;

public partial class OpalExeContext : DbContext
{
    public OpalExeContext()
    {
    }

    public OpalExeContext(DbContextOptions<OpalExeContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Customization> Customizations { get; set; }

    public virtual DbSet<Event> Events { get; set; }

    public virtual DbSet<Notification> Notifications { get; set; }

    public virtual DbSet<Payment> Payments { get; set; }

    public virtual DbSet<RefreshToken> RefreshTokens { get; set; }

    public virtual DbSet<Seed> Seeds { get; set; }

    public virtual DbSet<Subscription> Subscriptions { get; set; }

    public virtual DbSet<Task> Tasks { get; set; }

    public virtual DbSet<User> Users { get; set; }

    private string GetConnectionString()
    {
        IConfiguration configuration = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile("appsettings.json", true, true).Build();
        return configuration["ConnectionStrings:DefaultConnectionString"];
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer(GetConnectionString());
    }


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Customization>(entity =>
        {
            entity.HasKey(e => e.CustomizationId).HasName("PK__Customiz__D1DF8D89ADB48E7C");

            entity.Property(e => e.CustomizationId)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())")
                .HasColumnName("customization_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.ParrotHat)
                .HasMaxLength(50)
                .HasColumnName("parrot_hat");
            entity.Property(e => e.Theme)
                .HasMaxLength(50)
                .HasColumnName("theme");
            entity.Property(e => e.UserId)
                .HasMaxLength(36)
                .HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.Customizations)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Customiza__user___5070F446");
        });

        modelBuilder.Entity<Event>(entity =>
        {
            entity.HasKey(e => e.EventId).HasName("PK__Events__2370F727B5B713A4");

            entity.Property(e => e.EventId)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())")
                .HasColumnName("event_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.EventDescription).HasColumnName("event_description");
            entity.Property(e => e.EventTime)
                .HasColumnType("datetime")
                .HasColumnName("event_time");
            entity.Property(e => e.EventTitle)
                .HasMaxLength(255)
                .HasColumnName("event_title");
            entity.Property(e => e.NotificationTime)
                .HasColumnType("datetime")
                .HasColumnName("notification_time");
            entity.Property(e => e.Recurring).HasColumnName("recurring");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("datetime")
                .HasColumnName("updated_at");
            entity.Property(e => e.UserId)
                .HasMaxLength(36)
                .HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.Events)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Events__user_id__3F466844");
        });

        modelBuilder.Entity<Notification>(entity =>
        {
            entity.HasKey(e => e.NotificationId).HasName("PK__Notifica__E059842F4240E366");

            entity.Property(e => e.NotificationId)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())")
                .HasColumnName("notification_id");
            entity.Property(e => e.EventId)
                .HasMaxLength(36)
                .HasColumnName("event_id");
            entity.Property(e => e.IsSent).HasColumnName("is_sent");
            entity.Property(e => e.NotificationTime)
                .HasColumnType("datetime")
                .HasColumnName("notification_time");
            entity.Property(e => e.NotificationType)
                .HasMaxLength(50)
                .HasColumnName("notification_type");
            entity.Property(e => e.TaskId)
                .HasMaxLength(36)
                .HasColumnName("task_id");
            entity.Property(e => e.UserId)
                .HasMaxLength(36)
                .HasColumnName("user_id");

            entity.HasOne(d => d.Event).WithMany(p => p.Notifications)
                .HasForeignKey(d => d.EventId)
                .HasConstraintName("FK__Notificat__event__4CA06362");

            entity.HasOne(d => d.Task).WithMany(p => p.Notifications)
                .HasForeignKey(d => d.TaskId)
                .HasConstraintName("FK__Notificat__task___4BAC3F29");

            entity.HasOne(d => d.User).WithMany(p => p.Notifications)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Notificat__user___4AB81AF0");
        });

        modelBuilder.Entity<Payment>(entity =>
        {
            entity.HasKey(e => e.PaymentId).HasName("PK__Payments__ED1FC9EAC6ABE521");

            entity.HasIndex(e => e.TransactionId, "UQ__Payments__85C600AE0D8A0831").IsUnique();

            entity.Property(e => e.PaymentId)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())")
                .HasColumnName("payment_id");
            entity.Property(e => e.Amount)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("amount");
            entity.Property(e => e.PaymentDate)
                .HasColumnType("datetime")
                .HasColumnName("payment_date");
            entity.Property(e => e.PaymentMethod)
                .HasMaxLength(50)
                .HasColumnName("payment_method");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .HasColumnName("status");
            entity.Property(e => e.SubscriptionId)
                .HasMaxLength(36)
                .HasColumnName("subscription_id");
            entity.Property(e => e.TransactionId)
                .HasMaxLength(100)
                .HasColumnName("transaction_id");
            entity.Property(e => e.UserId)
                .HasMaxLength(36)
                .HasColumnName("user_id");

            entity.HasOne(d => d.Subscription).WithMany(p => p.Payments)
                .HasForeignKey(d => d.SubscriptionId)
                .HasConstraintName("FK__Payments__subscr__5629CD9C");

            entity.HasOne(d => d.User).WithMany(p => p.Payments)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Payments__user_i__5535A963");
        });

        modelBuilder.Entity<RefreshToken>(entity =>
        {
            entity.HasKey(e => e.TokenId).HasName("PK__RefreshT__CB3C9E176A6FA105");

            entity.Property(e => e.TokenId)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())")
                .HasColumnName("token_id");
            entity.Property(e => e.ExpiresAt)
                .HasColumnType("datetime")
                .HasColumnName("expires_at");
            entity.Property(e => e.IsRevoked).HasColumnName("is_revoked");
            entity.Property(e => e.IssuedAt)
                .HasColumnType("datetime")
                .HasColumnName("issued_at");
            entity.Property(e => e.RefreshToken1)
                .HasMaxLength(255)
                .HasColumnName("refresh_token");
            entity.Property(e => e.UserId)
                .HasMaxLength(36)
                .HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.RefreshTokens)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__RefreshTo__user___59FA5E80");
        });

        modelBuilder.Entity<Seed>(entity =>
        {
            entity.HasKey(e => e.SeedId).HasName("PK__Seeds__834250E1E3ACA91F");

            entity.Property(e => e.SeedId)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())")
                .HasColumnName("seed_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.ParrotLevel)
                .HasMaxLength(50)
                .HasColumnName("parrot_level");
            entity.Property(e => e.SeedCount).HasColumnName("seed_count");
            entity.Property(e => e.UserId)
                .HasMaxLength(36)
                .HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.Seeds)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Seeds__user_id__4316F928");
        });

        modelBuilder.Entity<Subscription>(entity =>
        {
            entity.HasKey(e => e.SubscriptionId).HasName("PK__Subscrip__863A7EC1056EFDDE");

            entity.Property(e => e.SubscriptionId)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())")
                .HasColumnName("subscription_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.EndDate).HasColumnName("end_date");
            entity.Property(e => e.PaymentAmount)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("payment_amount");
            entity.Property(e => e.PaymentMethod)
                .HasMaxLength(50)
                .HasColumnName("payment_method");
            entity.Property(e => e.Plan)
                .HasMaxLength(50)
                .HasColumnName("plan");
            entity.Property(e => e.StartDate).HasColumnName("start_date");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .HasColumnName("status");
            entity.Property(e => e.UserId)
                .HasMaxLength(36)
                .HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.Subscriptions)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Subscript__user___46E78A0C");
        });

        modelBuilder.Entity<Task>(entity =>
        {
            entity.HasKey(e => e.TaskId).HasName("PK__Tasks__0492148D1AB5F732");

            entity.Property(e => e.TaskId)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())")
                .HasColumnName("task_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.Description).HasColumnName("description");
            entity.Property(e => e.DueDate)
                .HasColumnType("datetime")
                .HasColumnName("due_date");
            entity.Property(e => e.IsCompleted).HasColumnName("is_completed");
            entity.Property(e => e.Priority)
                .HasMaxLength(50)
                .HasColumnName("priority");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .HasColumnName("status");
            entity.Property(e => e.Title)
                .HasMaxLength(255)
                .HasColumnName("title");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("datetime")
                .HasColumnName("updated_at");
            entity.Property(e => e.UserId)
                .HasMaxLength(36)
                .HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.Tasks)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Tasks__user_id__3B75D760");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__Users__B9BE370FB9D0047C");

            entity.HasIndex(e => e.Username, "UQ__Users__F3DBC5726A190809").IsUnique();

            entity.Property(e => e.UserId)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())")
                .HasColumnName("user_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.Password)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("password");
            entity.Property(e => e.PhoneNumber)
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("phone_number");
            entity.Property(e => e.Role)
                .HasMaxLength(50)
                .HasColumnName("role");
            entity.Property(e => e.SubscriptionPlan)
                .HasMaxLength(50)
                .HasColumnName("subscription_plan");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("datetime")
                .HasColumnName("updated_at");
            entity.Property(e => e.Username)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("username");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
