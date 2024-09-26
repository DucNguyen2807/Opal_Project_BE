using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.TaskDTOs
{
    public class TaskCreateRequestModel
    {
        public string Title { get; set; }
        public string Description { get; set; }
        public string Priority { get; set; }
        public DateTime? DueDate { get; set; }
        public TimeOnly? TimeTask { get; set; }
    }
}
