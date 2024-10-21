using Opal_Exe201.Data.DTOs.CustomizeDTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.CustomizeServices
{
    public interface ICustomizeService
    {
        Task<CustomizeReponseModel> GetCustomizeByUserAsync(string userId);
        Task<List<CustomizeReponseModel>> GetCustomizeAsync();
        Task<bool> UpdateUserCustomizationAsync(int customizeId, string token);
    }
}
