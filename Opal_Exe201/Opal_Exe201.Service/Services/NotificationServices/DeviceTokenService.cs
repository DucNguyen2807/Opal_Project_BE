using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;
using Opal_Exe201.Data.DTOs.DeviceTokenDTOS;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.NotificationServices
{
    public class DeviceTokenService : IDeviceTokenService
    {
        private readonly IUnitOfWork _unitOfWork;

        public DeviceTokenService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }


        public async Task<bool> SaveDeviceTokenAsync(string token, string deviceToken)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");
            if (string.IsNullOrEmpty(userId))
            {
                return false;
            }

            var user = await _unitOfWork.UsersRepository.GetByIDAsync(userId);
            if (user == null)
            {
                return false;
            }

            user.Devicetoken = deviceToken;
            await _unitOfWork.SaveAsync();

            return true;
        }
    }
}
