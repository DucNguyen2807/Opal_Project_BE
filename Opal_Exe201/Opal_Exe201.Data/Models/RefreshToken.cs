using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class RefreshToken
{
    public string TokenId { get; set; } = null!;

    public string? UserId { get; set; }

    public string RefreshToken1 { get; set; } = null!;

    public DateTime? IssuedAt { get; set; }

    public DateTime ExpiresAt { get; set; }

    public bool? IsRevoked { get; set; }

    public virtual User? User { get; set; }
}
