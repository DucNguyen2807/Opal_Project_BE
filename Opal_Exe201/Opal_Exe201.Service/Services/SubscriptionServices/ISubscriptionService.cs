using Opal_Exe201.Data.DTOs.PaymentService;
using Opal_Exe201.Data.DTOs.SubscriptionsDTOs;
using Opal_Exe201.Data.Enums.SubscriptionEnums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.SubscriptionServices
{
    public interface ISubscriptionService
    {
        Task<List<ViewSubscriptionsReponseModel>> GetActiveSubscriptions();
        Task<GetAllSubscriptionResponseModel> GetAllSubscription(string searchQuery, int pageIndex, int pageSize);
        Task<bool> ToggleSubscriptionStatus(string subscriptionId);
        System.Threading.Tasks.Task UpdateCoinPack(SubscriptionUpdateRequestModel requestModel, string id);
        Task<int> CreateCustomerSubscriptionTransaction(string token, string subscriptionId);
        Task<string> GetPaymentUrl(int paymentId, string redirectUrl);
        Task<bool> UpdatePaymentAndSubscription(int orderCode, string status);
    }
}
