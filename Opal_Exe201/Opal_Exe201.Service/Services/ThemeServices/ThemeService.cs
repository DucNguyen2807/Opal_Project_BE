using AutoMapper;
using Opal_Exe201.Data.DTOs.CustomizeDTOs;
using Opal_Exe201.Data.DTOs.ThemeDTOs;
using Opal_Exe201.Data.Enums.UserEnums;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.ThemeServices
{
    public class ThemeService : IThemeService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;

        public ThemeService(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }
        public async Task<ThemeReponseModel> GetThemeByUserAsync(string userId)
        {
            if (userId == null)
            {
                throw new Exception("UserId not found.");
            }

            var theme = await _unitOfWork.UserThemeRepository.GetAllDetail(userId);

            var themeResponse = new ThemeReponseModel
            {
                ThemeId = theme.ThemeId,
                BackgroundBird = theme.Theme.BackgroundBird,
                BackgroundHome = theme.Theme.BackgroundHome,
                Bird = theme.Theme.Bird,
                Bird1 = theme.Theme.Bird1,
                Icon1 = theme.Theme.Icon1,
                Icon2 = theme.Theme.Icon2,
                Icon3 = theme.Theme.Icon3,
                Icon4 = theme.Theme.Icon4,
                Icon5 = theme.Theme.Icon5,
                Icon6 = theme.Theme.Icon6,
                Icon7 = theme.Theme.Icon7,
                Icon8 = theme.Theme.Icon8,
                Icon9 =  theme.Theme.Icon9,
                Icon10 = theme.Theme.Icon10,
                Icon13 = theme.Theme.Icon13,
                Icon14 = theme.Theme.Icon14,
                Icon15 = theme.Theme.Icon15,
                LoginOpal = theme.Theme.LoginOpal,
                Logo = theme.Theme.Logo
            };

            return themeResponse;
        }

        public async Task<List<ThemeReponseModel>> GetThemeAsync()
        {

            var theme1 = await _unitOfWork.ThemeRepository.GetAsync();


            var themeResponse = theme1.Select(theme => new ThemeReponseModel
            {
                ThemeId = theme.ThemeId,
                BackgroundBird = theme.BackgroundBird,
                BackgroundHome = theme.BackgroundBird,
                Bird = theme.Bird,
                Bird1 = theme.Bird1,
                Icon1 = theme.Icon1,
                Icon2 = theme.Icon2,
                Icon3 = theme.Icon3,
                Icon4 = theme.Icon4,
                Icon5 = theme.Icon5,
                Icon6 = theme.Icon6,
                Icon7 = theme.Icon7,
                Icon8 = theme.Icon8,
                Icon9 = theme.Icon9,
                Icon10 = theme.Icon10,
                Icon13 = theme.Icon13,
                Icon14 = theme.Icon14,
                Icon15 = theme.Icon15,
                LoginOpal = theme.LoginOpal,
                Logo = theme.Logo
            }).ToList();


            return themeResponse;
        }
        public async Task<bool> UpdateUserThemeAsync(int themeId, string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");
            var user = await _unitOfWork.UsersRepository.GetByIDAsync(userId);
            var userTheme = await _unitOfWork.UserThemeRepository.GetAllDetail(userId);

            if (user.SubscriptionPlan.Equals(nameof(SubscriptionEnum.Free)))
            {
                throw new Exception("User don't have premium for choose this customize");
            }

            if (userTheme == null)
            {
                throw new Exception("User customization not found.");
            }

            userTheme.ThemeId = themeId;

            _unitOfWork.UserThemeRepository.Update(userTheme);

            _unitOfWork.Save();

            return true;
        }
    }
}
