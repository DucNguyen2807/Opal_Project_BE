using FirebaseAdmin.Messaging;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.FirebaseService
{
    public class SendNotificationToFirebase
    {
        public class NotificationService
        {
            private readonly IUnitOfWork _unitOfWork;

            public NotificationService(IUnitOfWork unitOfWork)
            {
                _unitOfWork = unitOfWork;
            }

            public async System.Threading.Tasks.Task CheckAndSendNotificationsAsync()
            {
                var notis = await _unitOfWork.NotificationRepository.GetAsync();

                var notifications = notis.Where(x => x.IsSent == false && x.NotificationTime <= DateTime.Now).ToList();

                foreach (var notification in notifications)
                {
                    await SendNotificationToFirebase(notification);
                    notification.IsSent = true;
                    await _unitOfWork.NotificationRepository.UpdateAsync(notification.NotificationId, notification);
                }
                await _unitOfWork.SaveAsync();
            }

            private async System.Threading.Tasks.Task SendNotificationToFirebase(Opal_Exe201.Data.Models.Notification notification)
            {
                // Fetch the user's device token from your database
                var user = await _unitOfWork.UsersRepository.GetByIDAsync(notification.UserId);
                string deviceToken = user.Devicetoken;

                if (string.IsNullOrEmpty(deviceToken))
                {
                    Console.WriteLine("Device token is missing for user.");
                    return;
                }

                var message = new Message()
                {
                    Token = deviceToken,
                    Notification = new FirebaseAdmin.Messaging.Notification()
                    {
                        Title = "Nhắc nhở sự kiện",
                        Body = $"Bạn có một sự kiện sắp diễn ra: {notification.EventId}",
                    },
                };

                try
                {
                    string response = await FirebaseMessaging.DefaultInstance.SendAsync(message);
                    Console.WriteLine("Successfully sent message: " + response);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error sending message: " + ex.Message);
                }
            }

        }
    }
}
