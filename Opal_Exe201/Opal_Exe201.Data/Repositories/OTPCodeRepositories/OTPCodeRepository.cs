using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.Repositories.GenericRepository;
using Opal_Exe201.Data.Repositories.PaymentRepositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.Repositories.OTPCodeRepositories
{
    public class OTPCodeRepository : GenericRepository<Otpcode>, IOTPCodeRepository
    {
        public OTPCodeRepository(OpalExeContext context) : base(context)
        {
        }
    }
}
