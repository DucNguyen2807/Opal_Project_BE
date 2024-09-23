using AutoMapper;
using Opal_Exe201.Data.DTOs.TaskDTOs;
using Opal_Exe201.Data.DTOs.UserDTOs;
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

        public TaskService(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }

        public async Task<List<TaskByDateReponseModel>> GetTasksByDateAsync(DateTime date, string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");

            var tasks = await _unitOfWork.TaskRepository.GetAsync(m => m.DueDate.HasValue && m.DueDate.Value.Date == date.Date && m.UserId == userId);

            if (tasks == null || !tasks.Any())
            {
                return new List<TaskByDateReponseModel>();
            }

            var taskResponse = tasks.Select(task => new TaskByDateReponseModel
            {
                title = task.Title,
                description = task.Description,
                date = task.DueDate.HasValue ? task.DueDate.Value.ToString("yyyy-MM-dd") : null,
                priority = task.Priority.ToString(), 
                IsCompleted = task.IsCompleted ?? false
            }).ToList();

            return taskResponse;
        }


    }
}
