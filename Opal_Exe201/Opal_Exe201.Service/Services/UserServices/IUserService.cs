﻿using Opal_Exe201.Data.DTOs.UserDTOs;

namespace Opal_Exe201.Service.Services.UserServices
{
    public interface IUserService
    {
        Task<UserLoginResponseModel> Login(UserLoginRequestModel request);
    }
}
