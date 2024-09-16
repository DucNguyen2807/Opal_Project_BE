using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class Otpcode
{
    public string Id { get; set; } = null!;

    public string Otp { get; set; } = null!;

    public DateTime CreatedAt { get; set; }

    public bool IsUsed { get; set; }

    public string CreatedBy { get; set; } = null!;

    public virtual User CreatedByNavigation { get; set; } = null!;
}
