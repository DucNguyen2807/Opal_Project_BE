using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.EventDTOS
{
    public class EventCreateRequest
    {
        public string EventTitle { get; set; } = null!;
        public string? EventDescription { get; set; }
        public string? Priority { get; set; }
        public TimeOnly StartTime { get; set; }
        public TimeOnly EndTime { get; set; }
        public bool? Recurring { get; set; }
    }
}
