using AutoMapper;
using Opal_Exe201.Data.DTOs.PaymentService;
using Opal_Exe201.Data.DTOs.UserDTOs;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Services.EmailServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.PaymentServices
{
    public class PaymentService : IPaymentService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;

        public PaymentService(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;

        }
        public async Task<GetAllPaymentResponseModel> GetAllPayment()
        {


            var payment = await _unitOfWork.PaymentRepository.GetAsync(includeProperties: "User,Subscription");

            var totalPayment = await _unitOfWork.PaymentRepository.CountAsync();

            var paymentResponses = _mapper.Map<List<ViewPaymentReponseModel>>(payment);

            return new GetAllPaymentResponseModel
            {
                Payment = paymentResponses,
                TotalPayment = totalPayment
            };
        }
        public async Task<GetAllPaymentResponseModel> GetAllPaymentOrderDate(string searchQuery, int pageIndex, int pageSize)
        {
            Expression<Func<Payment, bool>> searchFilter = u => string.IsNullOrEmpty(searchQuery) ||
                                                               u.User.Email.Contains(searchQuery) ||
                                                               u.PaymentMethod.Contains(searchQuery);
            //||                                                   u.PaymentDate.Contains(searchQuery);

            var payment = await _unitOfWork.PaymentRepository.GetAsync(searchFilter, pageIndex: pageIndex, pageSize: pageSize, includeProperties: "User,Subscription", orderBy: q => q.OrderByDescending(p => p.PaymentDate));

            var totalPayment = await _unitOfWork.PaymentRepository.CountAsync(searchFilter);

            var paymentResponses = _mapper.Map<List<ViewPaymentReponseModel>>(payment);

            return new GetAllPaymentResponseModel
            {
                Payment = paymentResponses,
                TotalPayment = totalPayment
            };
        }
    }
}
