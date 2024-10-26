using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.PaymentService
{
    public class GetAllPaymentResponseModel
    {
        public int TotalPayment { get; set; }
        public List<ViewPaymentReponseModel> Payment { get; set; }
    }
    public class ViewPaymentReponseModel
    {
        public int PaymentId { get; set; }

        public string? UserId { get; set; }

        public string? SubscriptionId { get; set; }

        public string TransactionId { get; set; } = null!;

        public decimal Amount { get; set; }

        public string PaymentMethod { get; set; } = null!;

        public DateTime? PaymentDate { get; set; }

        public string? Status { get; set; }

        public string UserEmail { get; set; } = null!;
        public string SubscriptionName { get; set; } = null!;

    }
}
