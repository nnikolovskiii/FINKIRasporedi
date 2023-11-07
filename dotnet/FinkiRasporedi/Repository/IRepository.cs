using FinkiRasporedi.Models.Base;

namespace FinkiRasporedi.Repository
{
    public interface IRepository<TEntity, TId>
    {
        Task<TEntity> GetByIdAsync(TId id);
        Task<IEnumerable<Professor>> GetPageAsync(int page, int pageSize);
        Task<int> GetTotalCountAsync();
        Task<TEntity> AddAsync(TEntity entity);
        Task<TEntity> UpdateAsync(TId id, TEntity entity);
        void DeleteAsync(TId id);
    }
}
