using Microsoft.EntityFrameworkCore.Storage;
using Opal_Exe201.Data.Repositories.CustomizationRepositories;
using Opal_Exe201.Data.Repositories.EventRepositories;
using Opal_Exe201.Data.Repositories.NotificationRepositories;
using Opal_Exe201.Data.Repositories.OTPCodeRepositories;
using Opal_Exe201.Data.Repositories.PaymentRepositories;
using Opal_Exe201.Data.Repositories.RefreshTokenRepositories;
using Opal_Exe201.Data.Repositories.SeedRepositories;
using Opal_Exe201.Data.Repositories.SubscriptionRepositories;
using Opal_Exe201.Data.Repositories.TasksRepositories;
using Opal_Exe201.Data.Repositories.UserCustomizeRepositories;
using Opal_Exe201.Data.Repositories.UserRepositories;
using Opal_Exe201.Data.Repositories.UserSubRepositories;
namespace Opal_Exe201.Data.UnitOfWorks
{
    public interface IUnitOfWork : IDisposable
    {
        ICustomizationRepository CustomizationRepository { get; }
        IEventRepository EventRepository { get; }
        INotificationRepository NotificationRepository { get; }
        IPaymentRepository PaymentRepository { get; }
        IRefreshTokenRepository RefreshTokenRepository { get; }
        ISeedRepository SeedRepository { get; }
        ISubscriptionRepository SubscriptionRepository { get; }
        ITaskRepository TaskRepository { get; }
        IUserRepository UsersRepository { get; }
        IUserSubRepository UserSubRepository { get; }
        IOTPCodeRepository OTPCodeRepository { get; }
        IUserCustomizeRepository UserCustomizeRepository { get; }

        Task<IDbContextTransaction> BeginTransactionAsync();

        Task SaveAsync();
        void Save();
    }
}
