using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.Repositories.GenericRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.Repositories.TasksRepositories
{
    public class TaskRepository : GenericRepository<Opal_Exe201.Data.Models.Task>, ITaskRepository
    {
        public TaskRepository(OpalExeContext context) : base(context)
        {
        }
    }
}
