using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.EventDTOS
{
    public class EventResponse
    {
        public string EventId { get; set; } = null!;
        public string EventTitle { get; set; } = null!;
        public string? EventDescription { get; set; }
        public string? Priority { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public DateTime? NotificationTime { get; set; }
    }
}
