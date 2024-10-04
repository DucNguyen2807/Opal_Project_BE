using AutoMapper;
using Opal_Exe201.Data.DTOs.EventDTOS;
using Opal_Exe201.Data.DTOs.SeedDTOS;
using Opal_Exe201.Data.DTOs.TaskDTOs;
using Opal_Exe201.Data.DTOs.UserDTOs;
using Opal_Exe201.Data.Models;

namespace Opal_Exe201.Data.Mapper
{
    public class MapperProfile : Profile
    {

        public MapperProfile() {
            //User
            CreateMap<UserRegisterRequestModel, User>().ReverseMap();

            //Event
            CreateMap<Event, EventCreateRequest>().ReverseMap();
            CreateMap<Event, EventResponse>().ReverseMap();

            //Seed
            CreateMap<Seed, FeedingResponseModel>()
                .ForMember(dest => dest.Message, opt => opt.Ignore());

            //Task
            CreateMap<TaskCreateRequestModel, Opal_Exe201.Data.Models.Task>()
                 .ForMember(dest => dest.TimeTask, opt => opt.MapFrom(src =>
                     src.TimeTask != null
                         ? new TimeOnly(src.TimeTask.Value.Hour, src.TimeTask.Value.Minute)
                         : (TimeOnly?)null)); 


        }
    }
}
