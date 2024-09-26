using Opal_Exe201.Data.DTOs.TaskDTOs;

namespace Opal_Exe201.Service.Services.TaskServices
{
    public interface ITaskService
    {
        Task<List<TaskByDateReponseModel>> GetTasksByDateAsync(DateTime date, string token);
        Task<bool> ToggleTaskCompletionAsync(string taskId, string token);
        System.Threading.Tasks.Task InsertTaskAsync(TaskCreateRequestModel taskRequest, string token);
    }
}
