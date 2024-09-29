using Microsoft.AspNetCore.SignalR;
using Opal_Exe201.Controllers.Hubs;
using Opal_Exe201.Data.Enums.NotificationType;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.NotificationServices
{
    public class NotificationService : INotificationService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IHubContext<NotificationHub> _hubContext;

        public NotificationService(IUnitOfWork unitOfWork, IHubContext<NotificationHub> hubContext)
        {
            _unitOfWork = unitOfWork;
            _hubContext = hubContext;
        }

        public async System.Threading.Tasks.Task NotifyUsersBeforeEvent()
        {
            var now = DateTime.Now;
            var notificationWindow = now.AddMinutes(5);

            Console.WriteLine($"NotifyUsersBeforeEvent is running at {now}");

            var notifications = await _unitOfWork.NotificationRepository.GetAsync(
                n => n.NotificationTime <= notificationWindow && n.NotificationTime > now && n.IsSent == false,
                includeProperties: "User,Event"
            );

            if (!notifications.Any())
            {
                Console.WriteLine("No notifications to send at this time.");
                return;
            }

            foreach (var notification in notifications)
            {
                if (notification.User == null || notification.Event == null)
                {
                    Console.WriteLine($"Notification with ID {notification.NotificationId} is missing related User or Event.");
                    continue;
                }

                Console.WriteLine($"Now: {now}, NotificationTime: {notification.NotificationTime}");

                Console.WriteLine($"Notification found: UserId: {notification.User.UserId}, EventTitle: {notification.Event.EventTitle}");

                bool isSent = await SendNotificationToClient(notification.User.UserId, notification.Event.EventTitle, notification.Event.StartTime);

                if (isSent)
                {
                    notification.IsSent = true;
                    await _unitOfWork.NotificationRepository.UpdateAsync(notification.NotificationId, notification);
                    Console.WriteLine($"Notification marked as sent for user {notification.User.UserId}.");
                }
            }

            _unitOfWork.Save();
        }

        private async Task<bool> SendNotificationToClient(string userId, string eventTitle, DateTime startTime)
        {
            try
            {
                Console.WriteLine($"Sending notification to user {userId} for event {eventTitle} at {startTime}.");

                string message = $"Event Reminder: {eventTitle} starts at {startTime}.";
                await _hubContext.Clients.User(userId).SendAsync("ReceiveNotification", message);
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Failed to send notification: {ex.Message}");
                return false;
            }
        }
    }
}
