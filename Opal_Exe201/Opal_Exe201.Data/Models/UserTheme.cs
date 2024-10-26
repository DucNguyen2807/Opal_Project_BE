using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class UserTheme
{
    public string UserThemeId { get; set; } = null!;

    public string? UserId { get; set; }

    public int? ThemeId { get; set; }

    public virtual Theme? Theme { get; set; }

    public virtual User? User { get; set; }
}
