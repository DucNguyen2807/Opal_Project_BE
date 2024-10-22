using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.PaymentService
{
    public class PaymentUpdateReqModel
    {
        public int paymentId { get; set; }

        public string status { get; set; } = null!;
    }
}
