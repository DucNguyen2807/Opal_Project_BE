using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.SeedDTOS
{
    public class FeedingRequestModel
    {
        [Required]
        [Range(1, int.MaxValue, ErrorMessage = "Feed amount must be at least 1.")]
        public int FeedAmount { get; set; }
    }
}
