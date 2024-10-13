using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class Customization
{
    public string CustomizationId { get; set; } = null!;

    public string? UserId { get; set; }

    public string? UiColor { get; set; }

    public string? FontColor { get; set; }

    public string? Font1 { get; set; }

    public string? Font2 { get; set; }

    public string? TextBoxColor { get; set; }

    public string? ButtonColor { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual User? User { get; set; }
}
