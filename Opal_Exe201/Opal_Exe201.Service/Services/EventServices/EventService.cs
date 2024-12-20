﻿using AutoMapper;
using Opal_Exe201.Data.DTOs.EventDTOS;
using Opal_Exe201.Data.Enums.NotificationType;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.UnitOfWorks;
using Opal_Exe201.Service.Services.EmailServices;
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

        public async Task<IEnumerable<EventResponse>> GetAllEventsByDateAsync(DateTime date, string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");
            var startOfDay = date.Date;
            var endOfDay = startOfDay.AddDays(1).AddTicks(-1);

            var events = await _unitOfWork.EventRepository.GetAsync(e =>
                e.StartTime >= startOfDay && e.EndTime <= endOfDay && e.UserId == userId);
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
            var eventEntity = new Event();

            DateOnly dateOnly = DateOnly.FromDateTime(DateTime.Now);

            eventEntity.EventTitle = eventRequest.EventTitle;
            eventEntity.EventDescription = eventRequest.EventDescription;
            eventEntity.Priority = eventRequest.Priority;
            eventEntity.Recurring = true;

            eventEntity.StartTime = dateOnly.ToDateTime(TimeOnly.Parse(eventRequest.StartTime.ToString()));
            eventEntity.EndTime = dateOnly.ToDateTime(TimeOnly.Parse(eventRequest.EndTime.ToString()));
            eventEntity.UserId = userId;
            eventEntity.CreatedAt = DateTime.Now;
            eventEntity.UpdatedAt = DateTime.Now;

            if (!eventEntity.NotificationTime.HasValue)
            {
                eventEntity.NotificationTime = eventEntity.StartTime.AddMinutes(-5);
            }

            await _unitOfWork.EventRepository.InsertAsync(eventEntity);
            _unitOfWork.Save();

            var notification = new Notification
            {
                UserId = userId,
                EventId = eventEntity.EventId,
                NotificationTime = (DateTime)eventEntity.NotificationTime,
                NotificationType = NotificationType.EventReminder.ToString(),
                IsSent = false
                
            };

            await _unitOfWork.NotificationRepository.InsertAsync(notification);
            _unitOfWork.Save();

            return _mapper.Map<EventResponse>(eventEntity);
        }

        public async Task<bool> UpdateEventAsync(string eventId, EventCreateRequest eventRequest, string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");
            var existingEvent = await _unitOfWork.EventRepository.GetByIDAsync(eventId.ToString());

            if (existingEvent == null || existingEvent.UserId != userId)
            {
                return false;
            }

            existingEvent.EventTitle = eventRequest.EventTitle;
            existingEvent.EventDescription = eventRequest.EventDescription;

            DateOnly dateOnly = DateOnly.FromDateTime(DateTime.Now);
            existingEvent.StartTime = dateOnly.ToDateTime(eventRequest.StartTime);
            existingEvent.EndTime = dateOnly.ToDateTime(eventRequest.EndTime);

            existingEvent.Recurring = eventRequest.Recurring;
            existingEvent.UpdatedAt = DateTime.UtcNow;

            if (!existingEvent.NotificationTime.HasValue)
            {
                existingEvent.NotificationTime = existingEvent.StartTime.AddMinutes(-5);
            }

            await _unitOfWork.EventRepository.UpdateAsync(eventId, existingEvent);

            var existingNotification = (await _unitOfWork.NotificationRepository.GetAsync(n => n.EventId == eventId.ToString())).FirstOrDefault();

            if (existingNotification != null)
            {
                existingNotification.NotificationTime = (DateTime)existingEvent.NotificationTime;
                await _unitOfWork.NotificationRepository.UpdateAsync(existingNotification.NotificationId, existingNotification);
            }
            else
            {
                var newNotification = new Notification
                {
                    UserId = userId,
                    EventId = eventId.ToString(),
                    NotificationTime = (DateTime)existingEvent.NotificationTime,
                    IsSent = false
                };
                await _unitOfWork.NotificationRepository.InsertAsync(newNotification);
            }

            _unitOfWork.Save();
            return true;
        }


        public async Task<bool> DeleteEventAsync(string eventId, string token)
        {
            var userId = JWTGenerate.DecodeToken(token, "UserId");
            try
            {
                var notifications = await _unitOfWork.NotificationRepository.GetAsync(n => n.EventId == eventId);

                foreach (var notification in notifications)
                {
                    await _unitOfWork.NotificationRepository.DeleteAsync(notification.NotificationId);
                }
                _unitOfWork.Save();

                var result = await _unitOfWork.EventRepository.DeleteAsync(eventId);
                _unitOfWork.Save();

                return result;
            }
            catch (Exception ex)
            {
                throw new ApplicationException($"An error occurred while deleting the event with ID {eventId}.", ex);
            }
        }
    }
}
