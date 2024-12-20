﻿using System;
using System.Collections.Generic;

namespace Opal_Exe201.Data.Models;

public partial class Theme
{
    public int ThemeId { get; set; }

    public string? BackgroundBird { get; set; }

    public string? BackgroundHome { get; set; }

    public string? Bird { get; set; }

    public string? Bird1 { get; set; }

    public string? Icon1 { get; set; }

    public string? Icon2 { get; set; }

    public string? Icon3 { get; set; }

    public string? Icon4 { get; set; }

    public string? Icon5 { get; set; }

    public string? Icon6 { get; set; }

    public string? Icon7 { get; set; }

    public string? Icon8 { get; set; }

    public string? Icon9 { get; set; }

    public string? Icon10 { get; set; }

    public string? Icon13 { get; set; }

    public string? Icon14 { get; set; }

    public string? Icon15 { get; set; }

    public string? LoginOpal { get; set; }

    public string? Logo { get; set; }

    public virtual ICollection<UserTheme> UserThemes { get; set; } = new List<UserTheme>();
}
