using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Logging;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Hubs
{
    public class NotificationHub : Hub
    {
        private readonly ILogger<NotificationHub> _logger;

        public NotificationHub(ILogger<NotificationHub> logger)
        {
            _logger = logger;
        }

        public async Task SendNotificationToUser(string userId, string message)
        {
            _logger.LogInformation($"Sending notification to user {userId}: {message}");
            await Clients.User(userId).SendAsync("ReceiveNotification", message);
        }

        public async Task SendNotificationToAll(string message)
        {
            _logger.LogInformation($"Sending notification to all users: {message}");
            await Clients.All.SendAsync("ReceiveNotification", message);
        }
        public override async Task OnConnectedAsync()
        {
            try
            {
                _logger.LogInformation($"Attempting to connect user: {Context.UserIdentifier}");

                if (string.IsNullOrEmpty(Context.UserIdentifier))
                {
                    _logger.LogWarning("UserIdentifier is null or empty. Ensure proper authentication.");
                }
                else
                {
                    _logger.LogInformation($"User successfully connected: {Context.UserIdentifier}");
                }

                await base.OnConnectedAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError($"Error during user connection: {ex.Message}");
            }
        }


        public override async Task OnDisconnectedAsync(Exception? exception)
        {
            _logger.LogInformation($"User disconnected: {Context.UserIdentifier}, Exception: {exception?.Message}");
            await base.OnDisconnectedAsync(exception);
        }
    }
}