using AutoMapper;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Services.EmailServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.NotificationServices
{
    public class NotificationService : INotificationService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IEmailService _emailService;

        public NotificationService(IUnitOfWork unitOfWork, IEmailService emailService)
        {
            _unitOfWork = unitOfWork;
            _emailService = emailService;
        }

        public async Task NotifyUsersBeforeEvent()
        {
            var now = DateTime.Now;
            var twoHoursLater = now.AddMinutes(5);

            Console.WriteLine($"NotifyUsersBeforeEvent is running at {now}");

            var notifications = await _unitOfWork.NotificationRepository.GetAsync(
                n => n.NotificationTime <= twoHoursLater && n.NotificationTime > now && n.IsSent == false,
                includeProperties: "User,Event"
);

            if (!notifications.Any())
            {
                Console.WriteLine("No notifications to send at this time.");
            }

            foreach (var notification in notifications)
            {
                if (notification.User == null || notification.Event == null)
                {
                    Console.WriteLine($"Notification with ID {notification.NotificationId} is missing related User or Event.");
                    continue;
                }

                Console.WriteLine($"Now: {now}, NotificationTime: {notification.NotificationTime}");

                await SendNotification(notification.User.Email, notification.Event.EventTitle, notification.Event.StartTime);

                notification.IsSent = true;
                await _unitOfWork.NotificationRepository.UpdateAsync(notification.NotificationId, notification);
            }


            _unitOfWork.Save();
        }



        private async Task SendNotification(string Email, string eventTitle, DateTime startTime)
        {
            Console.WriteLine($"Sending notification to {Email} for event {eventTitle} starting at {startTime} UTC.");

            var success = await _emailService.SendEmail(Email, "Sự kiện sắp bắt đầu", $"Sự kiện {eventTitle} sẽ bắt đầu lúc {startTime} UTC.");
            if (!success)
            {
                Console.WriteLine($"Failed to send email to {Email}");
            }
            else
            {
                Console.WriteLine($"Successfully sent email to {Email}");
            }
        }
    }
}
