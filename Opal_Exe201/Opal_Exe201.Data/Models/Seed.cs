using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class Seed
{
    public string SeedId { get; set; } = null!;

    public string? UserId { get; set; }

    public double? PercentGrowth { get; set; }

    public int? SeedCount { get; set; }

    public int ParrotLevel { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual User? User { get; set; }
}
