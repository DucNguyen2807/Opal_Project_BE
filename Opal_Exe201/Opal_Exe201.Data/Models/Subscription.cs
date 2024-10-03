using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class Subscription
{
    public string SubscriptionId { get; set; } = null!;

    public string SubName { get; set; } = null!;

    public DateOnly Duration { get; set; }

    public decimal? Price { get; set; }

    public string SubDescription { get; set; } = null!;

    public string? Status { get; set; }

    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();

    public virtual ICollection<UserSub> UserSubs { get; set; } = new List<UserSub>();
}
