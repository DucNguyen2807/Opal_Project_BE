using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.TaskDTOs
{
    public class ToggleTaskCompletionResponseModel
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public bool IsCompleted { get; set; }
    }
}
