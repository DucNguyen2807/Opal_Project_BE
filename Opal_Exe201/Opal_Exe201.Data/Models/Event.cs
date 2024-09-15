using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class Event
{
    public string EventId { get; set; } = null!;

    public string? UserId { get; set; }

    public string EventTitle { get; set; } = null!;

    public string? EventDescription { get; set; }

    public DateTime EventTime { get; set; }

    public DateTime? NotificationTime { get; set; }

    public bool? Recurring { get; set; }

    public DateTime? CreatedAt { get; set; }

    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<Notification> Notifications { get; set; } = new List<Notification>();

    public virtual User? User { get; set; }
}
