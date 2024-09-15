using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class Notification
{
    public string NotificationId { get; set; } = null!;

    public string? UserId { get; set; }

    public string? TaskId { get; set; }

    public string? EventId { get; set; }

    public DateTime NotificationTime { get; set; }

    public bool? IsSent { get; set; }

    public string? NotificationType { get; set; }

    public virtual Event? Event { get; set; }

    public virtual Task? Task { get; set; }

    public virtual User? User { get; set; }
}
