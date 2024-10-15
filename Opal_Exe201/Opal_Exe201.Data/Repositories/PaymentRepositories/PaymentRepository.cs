using Microsoft.EntityFrameworkCore;
using Opal_Exe201.Data.Models;
using Opal_Exe201.Data.Repositories.GenericRepository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.Repositories.PaymentRepositories
{
    public class PaymentRepository : GenericRepository<Payment>, IPaymentRepository
    {
        public PaymentRepository(OpalExeContext context) : base(context)
        {
        }
        public async Task<Payment?> FindAsync(Expression<Func<Payment, bool>> predicate, Func<IQueryable<Payment>, IQueryable<Payment>>? include = null)
        {
            IQueryable<Payment> query = _context.Payments;

            if (include != null)
            {
                query = include(query);
            }

            return await query.FirstOrDefaultAsync(predicate);
        }
        public async Task<int> InsertPaymentAsync(Payment payment)
        {
            await _context.AddAsync(payment);
            await _context.SaveChangesAsync();

            return payment.PaymentId;

        }
    }
}
