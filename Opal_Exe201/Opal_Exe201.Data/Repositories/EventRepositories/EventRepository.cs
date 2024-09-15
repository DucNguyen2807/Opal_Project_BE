using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.Repositories.GenericRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.Repositories.EventRepositories
{
    public class EventRepository : GenericRepository<Event>, IEventRepository
    {
        public EventRepository(OpalExeContext context) : base(context)
        {
        }
    }
}