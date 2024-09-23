using Opal_Exe201.Data.DTOs.TaskDTOs;
using Opal_Exe201.Data.DTOs.UserDTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.TaskServices
{
    public interface ITaskService
    {
        Task<List<TaskByDateReponseModel>> GetTasksByDateAsync(DateTime date, string token);
    }
}
