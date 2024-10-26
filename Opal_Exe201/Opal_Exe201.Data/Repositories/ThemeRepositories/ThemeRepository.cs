using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.Repositories.GenericRepository;
using Opal_Exe201.Data.Repositories.TasksRepositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.Repositories.ThemeRepositories
{
    public class ThemeRepository : GenericRepository<Theme>, IThemeRepository
    {
        public ThemeRepository(OpalExeContext context) : base(context)
        {
        }
    }
}
