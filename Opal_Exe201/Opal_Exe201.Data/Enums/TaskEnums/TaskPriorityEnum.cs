using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.Enums.TaskEnums
{
    public enum TaskPriorityEnum
    {
        [System.ComponentModel.Description("Quan trọng")]
        QuanTriang,

        [System.ComponentModel.Description("Bình thường")]
        BinhThuong,

        [System.ComponentModel.Description("Thường")]
        Thuong
    }
    
}
