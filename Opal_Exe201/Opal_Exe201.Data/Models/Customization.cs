using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class Customization
{
    public string CustomizationId { get; set; } = null!;

    public string? UserId { get; set; }

    public string? Theme { get; set; }

    public string? ParrotHat { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual User? User { get; set; }
}
