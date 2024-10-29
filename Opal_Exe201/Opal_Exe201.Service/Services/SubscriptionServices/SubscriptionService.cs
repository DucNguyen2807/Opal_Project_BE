using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Opal_Exe201.Data.DTOs.PaymentService;
using Opal_Exe201.Data.DTOs.SubscriptionsDTOs;
using Opal_Exe201.Data.Enums.SubscriptionEnums;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Services.PaymentServices;
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
        private readonly IPayOSService _payOSService;

        public SubscriptionService(IUnitOfWork unitOfWork, IMapper mapper, IPayOSService payOSService)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _payOSService = payOSService;
        }

        public async Task<List<ViewSubscriptionsReponseModel>> GetActiveSubscriptions()
        {
            var activeSubscriptions = await _unitOfWork.SubscriptionRepository.GetAsync(u => u.Status == "Active");

            return _mapper.Map<List<ViewSubscriptionsReponseModel>>(activeSubscriptions);
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

            subscription.Status = subscription.Status == "Active" ? "Not Active" : "Active";

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

        public async Task<int> CreateCustomerSubscriptionTransaction(string token, string subscriptionId)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");
            if (string.IsNullOrEmpty(userId))
                throw new Exception("User not found.");

            var subscription = await _unitOfWork.SubscriptionRepository.GetByIDAsync(subscriptionId);
            if (subscription == null)
                throw new Exception("Subscription not found.");

            var payment = new Payment
            {
                UserId = userId,
                SubscriptionId = subscriptionId,
                Amount = subscription.Price ?? 0,
                TransactionId = Guid.NewGuid().ToString(),
                PaymentDate = DateTime.Now,
                PaymentMethod = "Card",
                Status = "Pending"
            };

            var paymentId = await _unitOfWork.PaymentRepository.InsertPaymentAsync(payment);
            await _unitOfWork.SaveAsync();

            return paymentId;
        }

        public async Task<string> GetPaymentUrl(int paymentId, string redirectUrl)
        {
            var payment = await _unitOfWork.PaymentRepository.GetByIDAsync(paymentId);
            if (payment == null)
                throw new Exception("Payment does not exist.");

            if (payment.Status == "Success")
                throw new Exception("Payment has already been paid.");

            var subscription = await _unitOfWork.SubscriptionRepository.GetByIDAsync(payment.SubscriptionId);
            if (subscription == null)
                throw new Exception("Subscription does not exist.");

            var payOSReqModel = new PayOSReqModel
            {
                OrderId = payment.PaymentId,
                Amount = payment.Amount,
                SubName = subscription.SubName,
                RedirectUrl = redirectUrl,
                CancleUrl = redirectUrl,
            };

            var paymentResult = await _payOSService.CreatePaymentUrl(payOSReqModel);
            return paymentResult.checkoutUrl;
        }


        public async Task<bool> UpdatePaymentAndSubscription(int orderCode, string status)
        {
            var payments = await _unitOfWork.PaymentRepository.GetAsync(p => p.PaymentId == orderCode);
            var payment = payments.FirstOrDefault();

            if (payment != null)
            {
                payment.Status = status;
                payment.PaymentDate = DateTime.Now;
                _unitOfWork.PaymentRepository.Update(payment);

                if (status == "PAID")
                {
                    var user = await _unitOfWork.UsersRepository.GetByIDAsync(payment.UserId);
                    if (user != null)
                    {
                        var subscription = await _unitOfWork.SubscriptionRepository.GetByIDAsync(payment.SubscriptionId);

                        if (subscription != null)
                        {
                            user.SubscriptionPlan = "Premium";
                            _unitOfWork.UsersRepository.Update(user);

                            var existingUserSub = await _unitOfWork.UserSubRepository.GetAsync(
                                us => us.UserId == user.UserId && us.SubscriptionId == subscription.SubscriptionId && us.Status == "ACTIVE");

                            if (existingUserSub.Any())
                            {
                                var userSubscription = existingUserSub.First();
                                userSubscription.EndDate = DateOnly.FromDateTime(userSubscription.EndDate.ToDateTime(TimeOnly.MinValue).AddDays(subscription.Duration));
                                _unitOfWork.UserSubRepository.Update(userSubscription);
                            }
                            else
                            {
                                var newUserSubscription = new UserSub
                                {
                                    UserSubId = Guid.NewGuid().ToString(),
                                    UserId = user.UserId,
                                    SubscriptionId = subscription.SubscriptionId,
                                    StartDate = DateOnly.FromDateTime(DateTime.Now),
                                    EndDate = DateOnly.FromDateTime(DateTime.Now.AddDays(subscription.Duration)),
                                    Status = "ACTIVE",
                                    CreatedAt = DateTime.Now
                                };

                                await _unitOfWork.UserSubRepository.InsertAsync(newUserSubscription);
                            }
                        }
                    }
                }

                await _unitOfWork.SaveAsync();
                return true;
            }

            return false;
        }
    }
}
