using Opal_Exe201.Data.DTOs.PaymentService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.DTOs.SubscriptionsDTOs
{
    public class GetAllSubscriptionResponseModel
    {
        public int TotalSubscription { get; set; }
        public List<ViewSubscriptionsReponseModel> Subscription { get; set; }
    }
    public class ViewSubscriptionsReponseModel
    {
        public string SubscriptionId { get; set; } = null!;

        public string SubName { get; set; } = null!;

        public DateOnly Duration { get; set; }

        public decimal? Price { get; set; }

        public string SubDescription { get; set; } = null!;

        public string? Status { get; set; }
    }
}
