using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class User
{
    public string UserId { get; set; } = null!;

    public string Username { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string? Fullname { get; set; }

    public string? Email { get; set; }

    public string? Gender { get; set; }

    public string? PhoneNumber { get; set; }

    public string? SubscriptionPlan { get; set; }

    public string? Role { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public string? Devicetoken { get; set; }

    public virtual ICollection<Customization> Customizations { get; set; } = new List<Customization>();

    public virtual ICollection<Event> Events { get; set; } = new List<Event>();

    public virtual ICollection<Notification> Notifications { get; set; } = new List<Notification>();

    public virtual ICollection<Otpcode> Otpcodes { get; set; } = new List<Otpcode>();

    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();

    public virtual ICollection<RefreshToken> RefreshTokens { get; set; } = new List<RefreshToken>();

    public virtual ICollection<Seed> Seeds { get; set; } = new List<Seed>();

    public virtual ICollection<Task> Tasks { get; set; } = new List<Task>();

    public virtual ICollection<UserSub> UserSubs { get; set; } = new List<UserSub>();
}
