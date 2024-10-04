using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.SeedDTOS
{
    public class FeedingResponseModel
    {
        public int SeedCount { get; set; }
        public double PercentGrowth { get; set; }
        public int ParrotLevel { get; set; }
        public string Message { get; set; }
    }
}
