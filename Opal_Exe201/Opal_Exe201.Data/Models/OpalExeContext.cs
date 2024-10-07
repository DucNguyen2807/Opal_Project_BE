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

    public virtual DbSet<Otpcode> Otpcodes { get; set; }

    public virtual DbSet<Payment> Payments { get; set; }

    public virtual DbSet<RefreshToken> RefreshTokens { get; set; }

    public virtual DbSet<Seed> Seeds { get; set; }

    public virtual DbSet<Subscription> Subscriptions { get; set; }

    public virtual DbSet<Task> Tasks { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<UserSub> UserSubs { get; set; }

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
            entity.HasKey(e => e.CustomizationId).HasName("PK__Customiz__D1DF8D89885799EF");

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
                .HasConstraintName("FK__Customiza__user___5812160E");
        });

        modelBuilder.Entity<Event>(entity =>
        {
            entity.HasKey(e => e.EventId).HasName("PK__Events__2370F7278853E358");

            entity.Property(e => e.EventId)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())")
                .HasColumnName("event_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.EndTime)
                .HasColumnType("datetime")
                .HasColumnName("end_time");
            entity.Property(e => e.EventDescription).HasColumnName("event_description");
            entity.Property(e => e.EventTitle)
                .HasMaxLength(255)
                .HasColumnName("event_title");
            entity.Property(e => e.NotificationTime)
                .HasColumnType("datetime")
                .HasColumnName("notification_time");
            entity.Property(e => e.Priority)
                .HasMaxLength(100)
                .HasColumnName("priority");
            entity.Property(e => e.Recurring).HasColumnName("recurring");
            entity.Property(e => e.StartTime)
                .HasColumnType("datetime")
                .HasColumnName("start_time");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("datetime")
                .HasColumnName("updated_at");
            entity.Property(e => e.UserId)
                .HasMaxLength(36)
                .HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.Events)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Events__user_id__4316F928");
        });

        modelBuilder.Entity<Notification>(entity =>
        {
            entity.HasKey(e => e.NotificationId).HasName("PK__Notifica__E059842FA2E88FC6");

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
                .HasConstraintName("FK__Notificat__event__5441852A");

            entity.HasOne(d => d.Task).WithMany(p => p.Notifications)
                .HasForeignKey(d => d.TaskId)
                .HasConstraintName("FK__Notificat__task___534D60F1");

            entity.HasOne(d => d.User).WithMany(p => p.Notifications)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Notificat__user___52593CB8");
        });

        modelBuilder.Entity<Otpcode>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__OTPCode__3214EC078512E668");

            entity.ToTable("OTPCode");

            entity.Property(e => e.Id)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())");
            entity.Property(e => e.CreatedAt).HasColumnType("datetime");
            entity.Property(e => e.CreatedBy).HasMaxLength(36);
            entity.Property(e => e.Otp)
                .HasMaxLength(6)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("OTP");

            entity.HasOne(d => d.CreatedByNavigation).WithMany(p => p.Otpcodes)
                .HasForeignKey(d => d.CreatedBy)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__OTPCode__Created__3B75D760");
        });

        modelBuilder.Entity<Payment>(entity =>
        {
            entity.HasKey(e => e.PaymentId).HasName("PK__Payments__ED1FC9EA6D642888");

            entity.HasIndex(e => e.TransactionId, "UQ__Payments__85C600AEEC2528DD").IsUnique();

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
                .HasConstraintName("FK__Payments__subscr__5DCAEF64");

            entity.HasOne(d => d.User).WithMany(p => p.Payments)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Payments__user_i__5CD6CB2B");
        });

        modelBuilder.Entity<RefreshToken>(entity =>
        {
            entity.HasKey(e => e.TokenId).HasName("PK__RefreshT__CB3C9E1752EB2DC9");

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
                .HasConstraintName("FK__RefreshTo__user___619B8048");
        });

        modelBuilder.Entity<Seed>(entity =>
        {
            entity.HasKey(e => e.SeedId).HasName("PK__Seeds__834250E181D61B38");

            entity.Property(e => e.SeedId)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())")
                .HasColumnName("seed_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.ParrotLevel).HasColumnName("parrot_level");
            entity.Property(e => e.PercentGrowth).HasColumnName("percent_growth");
            entity.Property(e => e.SeedCount).HasColumnName("seed_count");
            entity.Property(e => e.UserId)
                .HasMaxLength(36)
                .HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.Seeds)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Seeds__user_id__46E78A0C");
        });

        modelBuilder.Entity<Subscription>(entity =>
        {
            entity.HasKey(e => e.SubscriptionId).HasName("PK__Subscrip__863A7EC1DBCD813F");

            entity.Property(e => e.SubscriptionId)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())")
                .HasColumnName("subscription_id");
            entity.Property(e => e.Price).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .HasColumnName("status");
            entity.Property(e => e.SubName).HasMaxLength(150);
        });

        modelBuilder.Entity<Task>(entity =>
        {
            entity.HasKey(e => e.TaskId).HasName("PK__Tasks__0492148D20BC1044");

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
            entity.Property(e => e.TimeTask).HasColumnName("time_task");
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
                .HasConstraintName("FK__Tasks__user_id__3F466844");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__Users__B9BE370F76A7ED7B");

            entity.HasIndex(e => e.Username, "UQ__Users__F3DBC572A2EED2EC").IsUnique();

            entity.Property(e => e.UserId)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())")
                .HasColumnName("user_id");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.Devicetoken)
                .HasMaxLength(100)
                .HasColumnName("devicetoken");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.Fullname)
                .HasMaxLength(255)
                .HasColumnName("fullname");
            entity.Property(e => e.Gender)
                .HasMaxLength(100)
                .HasColumnName("gender");
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

        modelBuilder.Entity<UserSub>(entity =>
        {
            entity.HasKey(e => e.UserSubId).HasName("PK__UserSub__7B2D2CA68F9D0D85");

            entity.ToTable("UserSub");

            entity.Property(e => e.UserSubId)
                .HasMaxLength(36)
                .HasDefaultValueSql("(newid())")
                .HasColumnName("UserSubID");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("datetime")
                .HasColumnName("created_at");
            entity.Property(e => e.EndDate).HasColumnName("end_date");
            entity.Property(e => e.StartDate).HasColumnName("start_date");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .HasColumnName("status");
            entity.Property(e => e.SubscriptionId)
                .HasMaxLength(36)
                .HasColumnName("subscription_id");
            entity.Property(e => e.UserId)
                .HasMaxLength(36)
                .HasColumnName("user_id");

            entity.HasOne(d => d.Subscription).WithMany(p => p.UserSubs)
                .HasForeignKey(d => d.SubscriptionId)
                .HasConstraintName("FK__UserSub__subscri__4E88ABD4");

            entity.HasOne(d => d.User).WithMany(p => p.UserSubs)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__UserSub__user_id__4D94879B");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
