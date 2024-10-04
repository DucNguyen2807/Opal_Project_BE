using Opal_Exe201.Data.DTOs.SeedDTOS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Service.Services.SeedServices
{
    public interface ISeedService
    {
        Task<FeedingResponseModel> FeedParrotAsync(FeedingRequestModel feedRequest, string token);
    }
}
