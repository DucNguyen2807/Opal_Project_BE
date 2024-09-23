﻿using Opal_Exe201.Data.DTOs.EventDTOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.EventServices
{
    public interface IEventService
    {
        Task<IEnumerable<EventResponse>> GetAllEventsAsync();
        Task<EventResponse> GetEventByIdAsync(string eventId,string token);
        Task<EventResponse> CreateEventAsync(EventCreateRequest eventRequest, string token);
        Task<bool> UpdateEventAsync(Guid eventId, EventCreateRequest eventRequest);
        Task<bool> DeleteEventAsync(Guid eventId);
    }
}