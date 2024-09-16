using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class UserSub
{
    public string UserSubId { get; set; } = null!;

    public string? UserId { get; set; }

    public string? SubscriptionId { get; set; }

    public DateOnly StartDate { get; set; }

    public DateOnly EndDate { get; set; }

    public string? Status { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual Subscription? Subscription { get; set; }

    public virtual User? User { get; set; }
}
