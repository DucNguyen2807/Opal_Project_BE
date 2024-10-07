using AutoMapper;
using Opal_Exe201.Data.DTOs.PaymentService;
using Opal_Exe201.Data.DTOs.SubscriptionsDTOs;
using Opal_Exe201.Data.Enums.SubscriptionEnums;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.SubscriptionServices
{
    public class SubscriptionService : ISubscriptionService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;

        public SubscriptionService(IUnitOfWork unitOfWork, IMapper mapper) {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }
        public async Task<GetAllSubscriptionResponseModel> GetAllSubscription(string searchQuery, int pageIndex, int pageSize)
        {
            Expression<Func<Subscription, bool>> searchFilter = u => string.IsNullOrEmpty(searchQuery) ||
                                                               u.SubName.Contains(searchQuery) ||
                                                               u.SubDescription.Contains(searchQuery);
            //||                                                   u.PaymentDate.Contains(searchQuery);

            var subscriptions = await _unitOfWork.SubscriptionRepository.GetAsync(searchFilter, pageIndex: pageIndex, pageSize: pageSize);

            var totalSubscription = await _unitOfWork.SubscriptionRepository.CountAsync(searchFilter);

            var paymentResponses = _mapper.Map<List<ViewSubscriptionsReponseModel>>(subscriptions);

            return new GetAllSubscriptionResponseModel
            {
                Subscription = paymentResponses,
                TotalSubscription = totalSubscription
            };
        }
        public async Task<bool> ToggleSubscriptionStatus(string subscriptionId)
        {
            var subscription = await _unitOfWork.SubscriptionRepository.GetByIDAsync(subscriptionId);

            if (subscription == null)
            {
                throw new Exception("Subscription not found.");
            }

            subscription.Status = subscription.Status == "Active" ? "Inactive" : "Active";

             _unitOfWork.SubscriptionRepository.UpdateAsync(subscriptionId, subscription);
            await _unitOfWork.SaveAsync(); 

            return true;
        }
        public async System.Threading.Tasks.Task UpdateCoinPack(SubscriptionUpdateRequestModel requestModel, string id)
        {
            if (id == null)
            {
                throw new CustomException("Please input id for update");
            }
            var subscription = await _unitOfWork.SubscriptionRepository.GetByIDAsync(id);
            if (subscription == null)
            {
                throw new CustomException("Cant find the coin pack");
            }
            _mapper.Map(requestModel, subscription);
            await _unitOfWork.SubscriptionRepository.UpdateAsync(id, subscription);
            _unitOfWork.Save();
        }



    }
}
