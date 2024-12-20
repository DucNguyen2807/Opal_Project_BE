﻿using AutoMapper;
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


        public async Task<ParrotResponseModel> GetParrotInfoAsync(string token)
        {
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
                    throw new InvalidOperationException("No seed record found. Please acquire seeds before viewing your parrot.");
                }

                var parrotViewModel = _mapper.Map<ParrotResponseModel>(seed);

                return parrotViewModel;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error retrieving parrot info for UserId: {UserId}", JWTGenerate.DecodeToken(token, "UserId"));
                throw;
            }
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

                if (seed.PercentGrowth == null || seed.SeedCount == null)
                {
                    throw new InvalidOperationException("Seed data is incomplete.");
                }

                var (requiredSeeds, growthIncrement) = GetFeedingParameters(seed.ParrotLevel);

                if (feedRequest.FeedAmount < requiredSeeds)
                {
                    throw new InvalidOperationException($"Insufficient feed amount for Parrot Level {seed.ParrotLevel}. You need at least {requiredSeeds} seeds to feed.");
                }

                if ((seed.SeedCount ?? 0) < feedRequest.FeedAmount)
                {
                    throw new InvalidOperationException("Insufficient seeds to perform the feeding action.");
                }

                int increments = feedRequest.FeedAmount / requiredSeeds;

                if (increments <= 0)
                {
                    throw new InvalidOperationException("Feed amount is too low to provide any growth.");
                }

                seed.SeedCount = (seed.SeedCount ?? 0) - (increments * requiredSeeds);
                seed.PercentGrowth = (seed.PercentGrowth ?? 0.0) + (increments * growthIncrement);

                while (seed.PercentGrowth >= 100 && seed.ParrotLevel < 5)
                {
                    seed.PercentGrowth -= 100;
                    seed.ParrotLevel += 1;
                }

                if (seed.ParrotLevel >= 5 && seed.PercentGrowth > 100)
                {
                    seed.ParrotLevel = 5;
                    seed.PercentGrowth = 100;
                }

                seed.LastFedDate = DateTime.Now;

                _unitOfWork.SeedRepository.Update(seed);

                await _unitOfWork.SaveAsync();
                await transaction.CommitAsync();

                var feedResponse = _mapper.Map<FeedingResponseModel>(seed);
                feedResponse.Message = "Parrot fed successfully! Your seeds have been updated.";

                _logger.LogInformation("User {UserId} fed the parrot with {FeedAmount} seeds at Level {ParrotLevel}.", userId, feedRequest.FeedAmount, seed.ParrotLevel);

                return feedResponse;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error feeding parrot for UserId: {UserId}", JWTGenerate.DecodeToken(token, "UserId"));
                await transaction.RollbackAsync();
                throw;
            }
        }

        private (int requiredSeeds, double growthIncrement) GetFeedingParameters(int parrotLevel)
        {
            return parrotLevel switch
            {
                1 => (1, 33.33),
                2 => (1, 2.0),
                3 => (1, 1.33),
                4 => (1, 1.0),
                _ => throw new InvalidOperationException("Invalid Parrot Level.")
            };
        }
    }
}
