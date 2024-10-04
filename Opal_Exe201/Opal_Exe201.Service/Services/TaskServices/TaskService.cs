using AutoMapper;
using Microsoft.Extensions.Logging;
using Opal_Exe201.Data.DTOs.TaskDTOs;
using Opal_Exe201.Data.DTOs.UserDTOs;
using Opal_Exe201.Data.Enums.TaskEnums;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.TaskServices
{
    public class TaskService : ITaskService
    {
        private IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly ILogger<TaskService> _logger;

        public TaskService(IUnitOfWork unitOfWork, IMapper mapper, ILogger<TaskService> logger)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
        }

        public async Task<List<TaskByDateReponseModel>> GetTasksByDateAsync(DateTime date, string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");

            var tasks = await _unitOfWork.TaskRepository.GetAsync(
                        filter: m => m.DueDate.HasValue && m.DueDate.Value.Date == date.Date && m.UserId == userId,
                        orderBy: q => q.OrderByDescending(t => t.IsCompleted).ThenBy(t => t.TimeTask));


            if (tasks == null || !tasks.Any())
            {
                return new List<TaskByDateReponseModel>();
            }

            var taskResponse = tasks.Select(task => new TaskByDateReponseModel
            {
                taskId = task.TaskId,
                title = task.Title,
                description = task.Description,
                time = task.TimeTask.HasValue ? task.TimeTask.Value.ToString(@"HH\:mm") : null,
                date = task.DueDate.HasValue ? task.DueDate.Value.ToString("yyyy-MM-dd") : null,
                priority = task.Priority.ToString(), 
                IsCompleted = task.IsCompleted ?? false
            }).ToList();

            return taskResponse;
        }
        public async Task<TaskByDateResponseWithCountModel> GetTasksByDateandPriorityAsync(DateTime date, string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");

            var tasks = await _unitOfWork.TaskRepository.GetAsync(
                filter: m => m.DueDate.HasValue && m.DueDate.Value.Date == date.Date && m.UserId == userId && m.Priority.Equals("Quan Trọng"),
                orderBy: q => q.OrderByDescending(t => t.IsCompleted).ThenBy(t => t.TimeTask)
            );

            if (tasks == null || !tasks.Any())
            {
                return new TaskByDateResponseWithCountModel
                {
                    totalTask = 0,
                    tasks = new List<TaskByDateResponseModel>()
                };
            }

            var taskResponse = tasks.Select(task => new TaskByDateResponseModel
            {
                taskId = task.TaskId,
                title = task.Title,
                description = task.Description,
                time = task.TimeTask.HasValue ? task.TimeTask.Value.ToString(@"HH\:mm") : null,
                date = task.DueDate.HasValue ? task.DueDate.Value.ToString("yyyy-MM-dd") : null,
                priority = task.Priority.ToString(),
                IsCompleted = task.IsCompleted ?? false
            }).ToList();

            return new TaskByDateResponseWithCountModel
            {
                totalTask = tasks.Count(),
                tasks = taskResponse 
            };
        }

        public async Task<bool> ToggleTaskCompletionAsync(string taskId, string token)
        {
            using var transaction = await _unitOfWork.BeginTransactionAsync();

            try
            {
                var userId = JWTGenerate.DecodeToken(token, "UserId");
                var task = await _unitOfWork.TaskRepository.GetByIDAsync(taskId);

                if (task == null || task.UserId != userId)
                {
                    return false;
                }

                bool wasCompleted = task.IsCompleted ?? false;
                task.IsCompleted = !wasCompleted;
                task.Status = task.IsCompleted.Value ? "True" : "False";
                _unitOfWork.TaskRepository.Update(task);

                if (!wasCompleted && task.IsCompleted.Value)
                {
                    var seed = await _unitOfWork.SeedRepository.GetSeedByUserIdAsync(userId);

                    if (seed != null)
                    {
                        seed.SeedCount += 1;
                        _unitOfWork.SeedRepository.Update(seed);
                    }
                    else
                    {
                        seed = new Seed
                        {
                            SeedId = Guid.NewGuid().ToString(),
                            UserId = userId,
                            SeedCount = 1,
                            CreatedAt = DateTime.Now,
                        };
                        await _unitOfWork.SeedRepository.InsertAsync(seed);
                    }
                }

                await _unitOfWork.SaveAsync();
                await transaction.CommitAsync();
                return true;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error toggling task completion for TaskId: {TaskId}", taskId);
                await transaction.RollbackAsync();
                throw;
            }
        }
        public async System.Threading.Tasks.Task InsertTaskAsync(TaskCreateRequestModel taskRequest, string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");
            if (string.IsNullOrEmpty(userId))
            {
                throw new ArgumentException("Invalid user token.");
            }
            if (taskRequest == null)
            {
                throw new ArgumentNullException(nameof(taskRequest), "Task request cannot be null.");
            }
            if (string.IsNullOrWhiteSpace(taskRequest.Title))
            {
                throw new ArgumentException("Task title cannot be empty.");
            }
            if (taskRequest.DueDate.HasValue && taskRequest.DueDate.Value.Date < DateTime.UtcNow.Date)
            {
                throw new ArgumentException("Due date cannot be in the past.");
            }

            Opal_Exe201.Data.Models.Task newTask = _mapper.Map<Opal_Exe201.Data.Models.Task>(taskRequest);

            newTask.TaskId = Guid.NewGuid().ToString();
            newTask.UserId = userId;
            newTask.Title = taskRequest.Title;
            newTask.Description = taskRequest.Description;
            newTask.Priority = taskRequest.Priority;
            newTask.DueDate = taskRequest.DueDate;
            newTask.TimeTask = taskRequest.TimeTask;
            newTask.IsCompleted = false;
            newTask.Status = "False";
            newTask.CreatedAt = DateTime.UtcNow;
            newTask.UpdatedAt = DateTime.UtcNow;

            await _unitOfWork.TaskRepository.InsertAsync(newTask);

             _unitOfWork.Save();
        }
        public async Task<bool> DeleteTaskAsync(string taskId, string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");

            var task = await _unitOfWork.TaskRepository.GetByIDAsync(taskId);

            if (task == null || task.UserId != userId)
            {
                return false;
            }

            _unitOfWork.TaskRepository.Delete(task);

             _unitOfWork.Save();

            return true; 
        }


    }
}
