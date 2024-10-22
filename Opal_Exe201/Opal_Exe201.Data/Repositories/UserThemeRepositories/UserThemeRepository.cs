using Microsoft.EntityFrameworkCore;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.Repositories.GenericRepository;
using Opal_Exe201.Data.Repositories.ThemeRepositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.Repositories.UserThemeRepositories
{
    public class UserThemeRepository : GenericRepository<UserTheme>, IUserThemeRepository
    {
        public UserThemeRepository(OpalExeContext context) : base(context)
        {
        }
        public async Task<UserTheme> GetAllDetail(string userId)
        {
            var theme = await _context.UserThemes
            .Include(m => m.Theme)
            .FirstOrDefaultAsync(m => m.UserId.Equals(userId));
            return theme;
        }
    }
}
