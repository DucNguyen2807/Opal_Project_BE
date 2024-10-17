using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Opal_Exe201.Data.UnitOfWorks;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.SeedServices
{
    public class ParrotMaintenanceService : BackgroundService
    {
        private readonly IServiceScopeFactory _serviceScopeFactory;
        private readonly ILogger<ParrotMaintenanceService> _logger;
        private readonly TimeSpan _checkInterval = TimeSpan.FromHours(24);

        public ParrotMaintenanceService(IServiceScopeFactory serviceScopeFactory, ILogger<ParrotMaintenanceService> logger)
        {
            _serviceScopeFactory = serviceScopeFactory;
            _logger = logger;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("Parrot Maintenance Service is starting.");

            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    await CheckAndUpdateParrotGrowthAsync();
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "An error occurred while checking Parrot growth.");
                }

                await Task.Delay(_checkInterval, stoppingToken);
            }

            _logger.LogInformation("Parrot Maintenance Service is stopping.");
        }

        private async Task CheckAndUpdateParrotGrowthAsync()
        {
            using (var scope = _serviceScopeFactory.CreateScope())
            {
                var unitOfWork = scope.ServiceProvider.GetRequiredService<IUnitOfWork>();
                var seeds = await unitOfWork.SeedRepository.GetAsync();

                foreach (var seed in seeds)
                {
                    if (seed.LastFedDate.HasValue)
                    {
                        var daysSinceLastFed = (DateTime.UtcNow - seed.LastFedDate.Value).TotalDays;
                        if (daysSinceLastFed >= 2)
                        {
                            if (seed.PercentGrowth.HasValue)
                            {
                                double originalPercent = seed.PercentGrowth.Value;
                                double reducedPercent = Math.Max(0, originalPercent * 0.5);

                                if (reducedPercent < originalPercent)
                                {
                                    seed.PercentGrowth = reducedPercent;
                                    unitOfWork.SeedRepository.Update(seed);
                                    _logger.LogInformation("Reduced PercentGrowth for UserId: {UserId} from {Original} to {Reduced}.", seed.UserId, originalPercent, reducedPercent);
                                }
                            }
                        }
                    }
                }

                await unitOfWork.SaveAsync();
            }
        }
    }
}
