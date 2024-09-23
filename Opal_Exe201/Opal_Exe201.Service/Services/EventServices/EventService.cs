using AutoMapper;
using Opal_Exe201.Data.DTOs.EventDTOS;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.EventServices
{
    public class EventService : IEventService
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;

        public EventService(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }

        public async Task<IEnumerable<EventResponse>> GetAllEventsAsync()
        {
            var events = await _unitOfWork.EventRepository.GetAsync();
            return _mapper.Map<IEnumerable<EventResponse>>(events);
        }

        public async Task<EventResponse> GetEventByIdAsync(string eventId, string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");
            var eventEntity = await _unitOfWork.EventRepository.GetByIDAsync(eventId);
            if (eventEntity == null)
                return null;
            return _mapper.Map<EventResponse>(eventEntity);
        }

        public async Task<EventResponse> CreateEventAsync(EventCreateRequest eventRequest, string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");
            var eventEntity = _mapper.Map<Event>(eventRequest);
            eventEntity.UserId = userId;
            eventEntity.CreatedAt = DateTime.UtcNow;
            eventEntity.UpdatedAt = DateTime.UtcNow;

            await _unitOfWork.EventRepository.InsertAsync(eventEntity);
            _unitOfWork.Save();

            return _mapper.Map<EventResponse>(eventEntity);
        }

        public async Task<bool> UpdateEventAsync(Guid eventId, EventCreateRequest eventRequest)
        {
            var existingEvent = await _unitOfWork.EventRepository.GetByIDAsync(eventId);
            if (existingEvent == null) return false;

            _mapper.Map(eventRequest, existingEvent);
            existingEvent.UpdatedAt = DateTime.UtcNow;

            await _unitOfWork.EventRepository.UpdateAsync(eventId, existingEvent);
            _unitOfWork.Save();

            return true;
        }

        public async Task<bool> DeleteEventAsync(Guid eventId)
        {
            var result = await _unitOfWork.EventRepository.DeleteAsync(eventId);
            _unitOfWork.Save();
            return result;
        }
    }
}
