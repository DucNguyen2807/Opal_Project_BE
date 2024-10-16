using Microsoft.EntityFrameworkCore;
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
        public async Task<UserCustomization> GetAllDetail(string userId)
        {
            var customization = await _context.UserCustomizations
            .Include(m => m.Customization)
            .FirstOrDefaultAsync(m => m.UserId.Equals(userId));
            return customization;
        }
    }
}
