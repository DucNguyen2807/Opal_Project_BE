using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.SeedDTOS
{
    public class ParrotResponseModel
    {
        public int ParrotLevel { get; set; }
        public int SeedCount { get; set; }
        public double PercentGrowth { get; set; }
        public DateTime LastFedDate { get; set; }
    }
}
