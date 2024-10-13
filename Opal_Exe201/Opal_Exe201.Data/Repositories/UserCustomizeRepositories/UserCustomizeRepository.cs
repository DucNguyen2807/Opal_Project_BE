using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.Repositories.GenericRepository;
using Opal_Exe201.Data.Repositories.UserRepositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.Repositories.UserCustomizeRepositories
{
    public class UserCustomizeRepository : GenericRepository<UserCustomization>, IUserCustomizeRepository
    {
        public UserCustomizeRepository(OpalExeContext context) : base(context)
        {
        }
    }
}
