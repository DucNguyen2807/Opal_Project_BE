using AutoMapper;
using Opal_Exe201.Data.DTOs.CustomizeDTOs;
using Opal_Exe201.Data.DTOs.TaskDTOs;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.CustomizeServices
{
    public class CustomizeService : ICustomizeService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;

        public CustomizeService(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }
        public async Task<CustomizeReponseModel> GetCustomizeByUserAsync(string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");

            var customize = await _unitOfWork.UserCustomizeRepository.GetAllDetail(userId);

            var customizeResponse = new CustomizeReponseModel
            {
                UiColor = customize.Customization.UiColor,
                FontColor = customize.Customization.FontColor,
                Font1 = customize.Customization.Font1,
                Font2 = customize.Customization.Font2,
                TextBoxColor = customize.Customization.TextBoxColor,
                ButtonColor = customize.Customization.ButtonColor
            };

            return customizeResponse;
        }

        public async Task<List<CustomizeReponseModel>> GetCustomizeAsync()
        {

            var customize = await _unitOfWork.CustomizationRepository.GetAsync();


            var customizeResponse = customize.Select(cus => new CustomizeReponseModel
            {
                CustomizationId = cus.CustomizationId,
                UiColor= cus.UiColor,
                FontColor= cus.FontColor,
                Font1 = cus.Font1,
                Font2 = cus.Font2,
                ButtonColor = cus.ButtonColor,
                TextBoxColor = cus.TextBoxColor,
            }).ToList();
            

            return customizeResponse;
        }
        public async Task<bool> UpdateUserCustomizationAsync(int customizeId, string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");

            var userCustomization = await _unitOfWork.UserCustomizeRepository.GetAllDetail(userId);


            if (userCustomization == null)
            {
                throw new Exception("User customization not found.");
            }

            userCustomization.CustomizationId = customizeId;

            _unitOfWork.UserCustomizeRepository.Update(userCustomization);

            _unitOfWork.Save(); 

            return true;
        }







    }
}
