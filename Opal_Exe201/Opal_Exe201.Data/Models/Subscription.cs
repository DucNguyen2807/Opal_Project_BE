using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class Subscription
{
    public string SubscriptionId { get; set; } = null!;

    public string? UserId { get; set; }

    public string Plan { get; set; } = null!;

    public DateOnly StartDate { get; set; }

    public DateOnly EndDate { get; set; }

    public decimal? PaymentAmount { get; set; }

    public string PaymentMethod { get; set; } = null!;

    public string? Status { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();

    public virtual User? User { get; set; }
}
