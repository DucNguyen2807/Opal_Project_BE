using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Logging;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Hubs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.Hangfire
{
    public class NotificationJob
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IHubContext<NotificationHub> _hubContext;
        private readonly ILogger<NotificationJob> _logger;

        public NotificationJob(IUnitOfWork unitOfWork, IHubContext<NotificationHub> hubContext, ILogger<NotificationJob> logger)
        {
            _unitOfWork = unitOfWork;
            _hubContext = hubContext;
            _logger = logger;
        }

        public async Task CheckAndSendNotifications()
        {
            _logger.LogInformation($"[{DateTime.Now}] Checking notifications...");

            var now = DateTime.Now;
            var dueNotifications = await _unitOfWork.NotificationRepository.GetAsync(n =>
                n.NotificationTime <= now && n.IsSent == false);

            _logger.LogInformation($"Found {dueNotifications.Count()} due notifications.");

            foreach (var notification in dueNotifications)
            {
                try
                {
                    _logger.LogInformation($"Sending notification {notification.NotificationId} to user {notification.UserId}");
                    await _hubContext.Clients.User(notification.UserId).SendAsync("ReceiveNotification", "Bạn có sự kiện sắp tới!");

                    notification.IsSent = true;
                    await _unitOfWork.NotificationRepository.UpdateAsync(notification.NotificationId, notification);

                    _logger.LogInformation($"Notification {notification.NotificationId} sent successfully.");
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, $"Error sending notification {notification.NotificationId}");
                }
            }

            await _unitOfWork.SaveAsync();
            _logger.LogInformation($"[{DateTime.Now}] Notifications checked and processed.");
        }
    }

}
