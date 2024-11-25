using Microsoft.Extensions.Configuration;
using Net.payOS.Types;
using Net.payOS;
using Opal_Exe201.Data.DTOs.PaymentService;
using Opal_Exe201.Service.Services.PaymentServices;
using Microsoft.Extensions.Logging;

public class PayOSService : IPayOSService
{
    private readonly IConfiguration _config;
    private readonly ILogger<PayOSService> _logger; // Thêm logger vào lớp

    // Cập nhật constructor để inject ILogger
    public PayOSService(IConfiguration config, ILogger<PayOSService> logger)
    {
        _config = config;
        _logger = logger;  // Gán giá trị logger vào biến _logger
    }

    public async Task<CreatePaymentResult> CreatePaymentUrl(PayOSReqModel payOSReqModel)
    {
        // Ghi log khi bắt đầu phương thức
        _logger.LogInformation("Dang tao URL thanh toan cho OrderId: {OrderId}, So tien: {Amount}", payOSReqModel.OrderId, payOSReqModel.Amount);

        try
        {
            // Khởi tạo client PayOS với các giá trị cấu hình
            PayOS payOS = new PayOS(
                _config["PayOS:ClientID"],
                _config["PayOS:ApiKey"],
                _config["PayOS:ChecksumKey"]
            );

            _logger.LogInformation("Da khoi tao client PayOS voi ClientID: {ClientID}", _config["PayOS:ClientID"]);

            // Tạo item thanh toán
            ItemData item = new ItemData(payOSReqModel.SubName, 1, (int)payOSReqModel.Amount);
            List<ItemData> items = new List<ItemData> { item };

            _logger.LogInformation("Da tao item thanh toan voi SubName: {SubName}, So tien: {Amount}", payOSReqModel.SubName, payOSReqModel.Amount);

            // Chuẩn bị dữ liệu thanh toán
            PaymentData paymentData = new PaymentData(
                payOSReqModel.OrderId,
                (int)payOSReqModel.Amount,
                payOSReqModel.SubName,
                items,
                payOSReqModel.CancleUrl,
                payOSReqModel.RedirectUrl
            );

            _logger.LogInformation("Du lieu thanh toan da duoc chuan bi cho OrderId: {OrderId}", payOSReqModel.OrderId);

            // Gọi PayOS để tạo link thanh toán
            CreatePaymentResult createPayment = await payOS.createPaymentLink(paymentData);

            if (createPayment != null && createPayment.status == "PENDING")
            {
                // Ghi log thành công
                _logger.LogInformation("Da tao URL thanh toan cho OrderId: {OrderId}", payOSReqModel.OrderId);
            }
            else
            {
                // Ghi log thất bại nếu việc tạo link thanh toán không thành công
                _logger.LogWarning("Tao URL thanh toan that bai cho OrderId: {OrderId}", payOSReqModel.OrderId);
            }

            // Trả về kết quả
            return createPayment;
        }
        catch (Exception ex)
        {
            // Ghi log khi có lỗi xảy ra
            _logger.LogError(ex, "Đã xảy ra lỗi khi tạo URL thanh toán cho OrderId: {OrderId}", payOSReqModel.OrderId);
            throw; // Ném lại ngoại lệ để xử lý ở nơi khác nếu cần
        }
    }
}
