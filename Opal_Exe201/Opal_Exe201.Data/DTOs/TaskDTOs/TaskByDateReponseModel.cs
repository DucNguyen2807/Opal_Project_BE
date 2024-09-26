using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.TaskDTOs
{
    public class TaskByDateReponseModel
    {
        public string taskId { get; set; }
        public string title { get; set; }
        public string description { get; set; }
        public string date { get; set; }
        public string time { get; set; }
        public string priority { get; set; }
        public bool IsCompleted { get; set; }
    }
}
