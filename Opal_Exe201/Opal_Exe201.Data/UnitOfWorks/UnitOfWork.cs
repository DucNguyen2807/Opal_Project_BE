using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.Repositories.CustomizationRepositories;
using Opal_Exe201.Data.Repositories.EventRepositories;
using Opal_Exe201.Data.Repositories.NotificationRepositories;
using Opal_Exe201.Data.Repositories.PaymentRepositories;
using Opal_Exe201.Data.Repositories.RefreshTokenRepositories;
using Opal_Exe201.Data.Repositories.SeedRepositories;
using Opal_Exe201.Data.Repositories.SubscriptionRepositories;
using Opal_Exe201.Data.Repositories.TasksRepositories;
using Opal_Exe201.Data.Repositories.UserRepositories;
using System.ComponentModel.DataAnnotations;

namespace Opal_Exe201.Data.UnitOfWorks
{
    public class UnitOfWork : IUnitOfWork, IDisposable
    {
        private OpalExeContext _context;
        private ICustomizationRepository _customizationRepository;
        private IEventRepository _eventRepository;
        private INotificationRepository _notificationRepository;
        private IPaymentRepository _paymentRepository;
        private IRefreshTokenRepository _refreshTokenRepository;
        private ISeedRepository _seedRepository;
        private ISubscriptionRepository _subscriptionRepository;
        private ITaskRepository _taskRepository;
        private IUserRepository _userRepository;


        public UnitOfWork(OpalExeContext context)
        {
            _context = context;
        }
        public ICustomizationRepository CustomizationRepository
        {
            get
            {
                return _customizationRepository ??= new CustomizationRepository(_context);
            }
        }
        public IEventRepository EventRepository
        {
            get
            {
                return _eventRepository ??= new EventRepository(_context);
            }
        }
        public INotificationRepository NotificationRepository
        {
            get
            {
                return _notificationRepository ??= new NotificationRepository(_context);
            }
        }

        public IPaymentRepository PaymentRepository
        {
            get
            {
                return _paymentRepository ??= new PaymentRepository(_context);
            }
        }
        public IRefreshTokenRepository RefreshTokenRepository
        {
            get
            {
                return _refreshTokenRepository ??= new RefreshTokenRepository(_context);
            }
        }
        public ISeedRepository SeedRepository
        {
            get
            {
                return _seedRepository ??= new SeedRepository(_context);
            }
        }
        public ISubscriptionRepository SubscriptionRepository
        {
            get
            {
                return _subscriptionRepository ??= new SubscriptionRepository(_context);
            }
        }
        public ITaskRepository TaskRepository
        {
            get
            {
                return _taskRepository ??= new TaskRepository(_context);
            }
        }
        public IUserRepository UsersRepository
        {
            get
            {
                return _userRepository ??= new UserRepository(_context);
            }
        }


        public void Save()
        {
            var validationErrors = _context.ChangeTracker.Entries<IValidatableObject>()
                .SelectMany(e => e.Entity.Validate(null))
                .Where(e => e != ValidationResult.Success)
                .ToArray();
            if (validationErrors.Any())
            {
                var exceptionMessage = string.Join(Environment.NewLine,
                    validationErrors.Select(error => $"Properties {error.MemberNames} Error: {error.ErrorMessage}"));
                throw new Exception(exceptionMessage);
            }
            _context.SaveChanges();
        }

        private bool disposed = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    _context.Dispose();
                }
                disposed = true;
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

    }
}