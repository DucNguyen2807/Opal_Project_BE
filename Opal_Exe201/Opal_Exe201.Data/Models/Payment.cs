using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class Payment
{
    public string PaymentId { get; set; } = null!;

    public string? UserId { get; set; }

    public string? SubscriptionId { get; set; }

    public string TransactionId { get; set; } = null!;

    public decimal Amount { get; set; }

    public string PaymentMethod { get; set; } = null!;

    public DateTime? PaymentDate { get; set; }

    public string? Status { get; set; }
}
