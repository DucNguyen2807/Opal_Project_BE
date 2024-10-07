using Microsoft.Extensions.Hosting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Opal_Exe201.Service.Services.FirebaseService.SendNotificationToFirebase;

namespace Opal_Exe201.Service.Services.NotificationServices
{
    public class NotificationBackgroundService : BackgroundService
    {
        private readonly NotificationService _notificationService;

        public NotificationBackgroundService(NotificationService notificationService)
        {
            _notificationService = notificationService;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                await _notificationService.CheckAndSendNotificationsAsync();
                await Task.Delay(TimeSpan.FromMinutes(1), stoppingToken);
            }
        }
    }

}
