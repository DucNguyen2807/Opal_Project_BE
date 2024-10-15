using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.PaymentService
{
    public class SubscriptionPaymentReqModel
    {
        public string SubscriptionId { get; set; }
        public string RedirectUrl { get; set; }
    }
}
