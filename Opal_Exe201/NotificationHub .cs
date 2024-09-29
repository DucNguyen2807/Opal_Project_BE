using Microsoft.AspNetCore.SignalR;

namespace Opal_Exe201.Hubs
{
    public class NotificationHub : Hub
    {
        public async Task SendNotification(string message)
        {
            await Clients.All.SendAsync("ReceiveNotification", message);
        }
    }
}
