using Opal_Exe201.Data.DTOs.PaymentService;
using Opal_Exe201.Data.DTOs.UserDTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.PaymentServices
{
    public interface IPaymentService
    {
        Task<GetAllPaymentResponseModel> GetAllPayment(string searchQuery, int pageIndex, int pageSize);
    }
}
