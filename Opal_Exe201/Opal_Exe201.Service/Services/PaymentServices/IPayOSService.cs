using Net.payOS.Types;
using Opal_Exe201.Data.DTOs.PaymentService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.PaymentServices
{
    public interface IPayOSService
    {
        Task<CreatePaymentResult> CreatePaymentUrl(PayOSReqModel payOSReqModel);
    }
}
