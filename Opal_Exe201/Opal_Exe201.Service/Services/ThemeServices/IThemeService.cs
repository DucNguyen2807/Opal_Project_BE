using Opal_Exe201.Data.DTOs.CustomizeDTOs;
using Opal_Exe201.Data.DTOs.ThemeDTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.ThemeServices
{
    public interface IThemeService
    {
        Task<ThemeReponseModel> GetThemeByUserAsync(string userId);
        Task<List<ThemeReponseModel>> GetThemeAsync();
        Task<bool> UpdateUserThemeAsync(int themeId, string token);
    }
}
