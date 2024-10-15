using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.PaymentService
{
    public class PayOSReqModel
    {
        public int OrderId { get; set; }
        public int PaymentId { get; set; }
        public decimal Amount { get; set; }
        public string SubName { get; set; }
        public string RedirectUrl { get; set; }
        public string CancleUrl { get; set; }
        public DateTime CreatedDate { get; set; }
    }
}
