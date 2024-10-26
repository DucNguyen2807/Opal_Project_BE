using Microsoft.EntityFrameworkCore.Storage;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.Repositories.CustomizationRepositories;
using Opal_Exe201.Data.Repositories.EventRepositories;
using Opal_Exe201.Data.Repositories.NotificationRepositories;
using Opal_Exe201.Data.Repositories.OTPCodeRepositories;
using Opal_Exe201.Data.Repositories.PaymentRepositories;
using Opal_Exe201.Data.Repositories.RefreshTokenRepositories;
using Opal_Exe201.Data.Repositories.SeedRepositories;
using Opal_Exe201.Data.Repositories.SubscriptionRepositories;
using Opal_Exe201.Data.Repositories.TasksRepositories;
using Opal_Exe201.Data.Repositories.ThemeRepositories;
using Opal_Exe201.Data.Repositories.UserCustomizeRepositories;
using Opal_Exe201.Data.Repositories.UserRepositories;
using Opal_Exe201.Data.Repositories.UserSubRepositories;
using Opal_Exe201.Data.Repositories.UserThemeRepositories;
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
        private IUserSubRepository _userSubRepository;
        private IOTPCodeRepository _otpCodeRepository;
        private IUserCustomizeRepository _userCustomizeRepository;
        private IThemeRepository _themeRepository;
        private IUserThemeRepository _userThemeRepository;

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
        public IUserSubRepository UserSubRepository
        {
            get
            {
                return _userSubRepository ??= new UserSubRepository(_context);
            }
        }
        public IOTPCodeRepository OTPCodeRepository
        {
            get
            {
                return _otpCodeRepository ??= new OTPCodeRepository(_context);
            }
        }

        public IUserCustomizeRepository UserCustomizeRepository
        {
            get
            {
                return _userCustomizeRepository ??= new UserCustomizeRepository(_context);
            }
        }

        public IThemeRepository ThemeRepository
        {
            get
            {
                return _themeRepository ??= new ThemeRepository(_context);
            }
        }

        public IUserThemeRepository UserThemeRepository
        {
            get
            {
                return _userThemeRepository ??= new UserThemeRepository(_context);
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

        public async System.Threading.Tasks.Task SaveAsync()
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
            await _context.SaveChangesAsync();
        }

        public async Task<IDbContextTransaction> BeginTransactionAsync()
        {
            return await _context.Database.BeginTransactionAsync();
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