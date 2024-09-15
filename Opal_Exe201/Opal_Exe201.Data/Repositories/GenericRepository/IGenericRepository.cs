using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Opal_Exe201.Data.Repositories.GenericRepository
{
    public interface IGenericRepository<T> where T : class
    {
        Task<IEnumerable<T>> GetAsync(
            Expression<Func<T, bool>>? filter = null,
            Func<IQueryable<T>, IOrderedQueryable<T>>? orderBy = null,
            string includeProperties = "",
            int? pageIndex = null,
            int? pageSize = null);

        Task<T> GetByIDAsync(object id);

        Task InsertAsync(T entity);

        Task<bool> DeleteAsync(object id);

        void Delete(T entityToDelete);
        Task<bool> UpdateAsync(object id, T entityToUpdate);
        void Update(T entityToUpdate);
    }
}
