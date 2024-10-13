using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class UserCustomization
{
    public string UserCustomizationId { get; set; } = null!;

    public string? UserId { get; set; }

    public int? CustomizationId { get; set; }

    public virtual Customization? Customization { get; set; }

    public virtual User? User { get; set; }
}
