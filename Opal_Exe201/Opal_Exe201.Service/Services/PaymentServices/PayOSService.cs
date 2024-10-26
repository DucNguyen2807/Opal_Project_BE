using Microsoft.Extensions.Configuration;
using Net.payOS.Types;
using Net.payOS;
using Opal_Exe201.Data.DTOs.PaymentService;
using Opal_Exe201.Service.Services.PaymentServices;

public class PayOSService : IPayOSService
{
    private readonly IConfiguration _config;

    public PayOSService(IConfiguration config)
    {
        _config = config;
    }

    public async Task<CreatePaymentResult> CreatePaymentUrl(PayOSReqModel payOSReqModel)
    {
        PayOS payOS = new PayOS(
            _config["PayOS:ClientID"],
            _config["PayOS:ApiKey"],
            _config["PayOS:ChecksumKey"]
        );

        // Tạo item thanh toán
        ItemData item = new ItemData(payOSReqModel.SubName, 1, (int)payOSReqModel.Amount);
        List<ItemData> items = new List<ItemData> { item };

        // Chuẩn bị dữ liệu thanh toán
        PaymentData paymentData = new PaymentData(
            payOSReqModel.OrderId,
            (int)payOSReqModel.Amount,
            payOSReqModel.SubName, 
            items, 
            payOSReqModel.CancleUrl, 
            payOSReqModel.RedirectUrl
        );

        CreatePaymentResult createPayment = await payOS.createPaymentLink(paymentData);

        return createPayment;
    }
}
