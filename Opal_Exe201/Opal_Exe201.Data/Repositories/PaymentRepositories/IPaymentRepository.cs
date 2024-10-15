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
    public interface IPaymentRepository : IGenericRepository<Payment>
    {
        Task<Payment?> FindAsync(Expression<Func<Payment, bool>> predicate, Func<IQueryable<Payment>, IQueryable<Payment>>? include = null);
        Task<int> InsertPaymentAsync(Payment payment);
    }
}
