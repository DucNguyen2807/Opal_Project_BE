using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class Customization
{
    public int CustomizationId { get; set; }

    public string? UiColor { get; set; }

    public string? FontColor { get; set; }

    public string? Font1 { get; set; }

    public string? Font2 { get; set; }

    public string? TextBoxColor { get; set; }

    public string? ButtonColor { get; set; }

    public DateTime? CreatedAt { get; set; }

    public virtual ICollection<UserCustomization> UserCustomizations { get; set; } = new List<UserCustomization>();
}
