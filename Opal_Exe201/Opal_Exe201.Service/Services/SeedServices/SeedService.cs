using AutoMapper;
using Microsoft.Extensions.Logging;
using Opal_Exe201.Data.DTOs.SeedDTOS;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Utils;
using System;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.SeedServices
{
    public class SeedService : ISeedService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly ILogger<SeedService> _logger;

        public SeedService(IUnitOfWork unitOfWork, IMapper mapper, ILogger<SeedService> logger)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
        }

        public async Task<FeedingResponseModel> FeedParrotAsync(FeedingRequestModel feedRequest, string token)
        {
            using var transaction = await _unitOfWork.BeginTransactionAsync();

            try
            {
                var userId = JWTGenerate.DecodeToken(token, "UserId");
                if (string.IsNullOrEmpty(userId))
                {
                    throw new ArgumentException("Invalid user token.");
                }

                var seed = await _unitOfWork.SeedRepository.GetSeedByUserIdAsync(userId);

                if (seed == null)
                {
                    throw new InvalidOperationException("No seed record found. Please acquire seeds before feeding.");
                }

                if (seed.SeedCount < feedRequest.FeedAmount)
                {
                    throw new InvalidOperationException("Insufficient seeds to perform the feeding action.");
                }

                seed.SeedCount -= feedRequest.FeedAmount;
                seed.PercentGrowth += feedRequest.FeedAmount * 0.1;

                if (seed.PercentGrowth >= 100)
                {
                    seed.PercentGrowth = seed.PercentGrowth % 100;
                    seed.ParrotLevel += 1;
                }

                _unitOfWork.SeedRepository.Update(seed);

                await _unitOfWork.SaveAsync();
                await transaction.CommitAsync();

                var feedResponse = _mapper.Map<FeedingResponseModel>(seed);
                feedResponse.Message = "Parrot fed successfully! Your seeds have been updated.";

                _logger.LogInformation("User {UserId} fed the parrot with {FeedAmount} seeds.", userId, feedRequest.FeedAmount);

                return feedResponse;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error feeding parrot for UserId: {UserId}", JWTGenerate.DecodeToken(token, "UserId"));
                await transaction.RollbackAsync();
                throw;
            }
        }
    }
}
