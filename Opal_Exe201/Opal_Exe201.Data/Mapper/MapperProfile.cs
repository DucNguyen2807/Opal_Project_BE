using AutoMapper;
using Opal_Exe201.Data.DTOs.UserDTOs;
using Opal_Exe201.Data.Models;

namespace Opal_Exe201.Data.Mapper
{
    public class MapperProfile : Profile
    {

        public MapperProfile() {
            //User
            CreateMap<UserRegisterRequestModel, User>();



        }
    }
}
