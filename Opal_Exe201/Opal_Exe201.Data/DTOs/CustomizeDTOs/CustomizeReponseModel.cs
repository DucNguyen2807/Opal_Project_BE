using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.CustomizeDTOs
{
    public class CustomizeReponseModel
    {
        public int CustomizationId { get; set; }
        public string? UiColor { get; set; }

        public string? FontColor { get; set; }

        public string? Font1 { get; set; }

        public string? Font2 { get; set; }

        public string? TextBoxColor { get; set; }

        public string? ButtonColor { get; set; }
    }
}
