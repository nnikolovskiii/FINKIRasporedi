namespace FinkiRasporedi.Repository
{
    public interface IRepository<TEntity, TId>
    {
        Task<TEntity> GetByIdAsync(TId id);
        Task<IEnumerable<TEntity>> GetPageAsync(int page, int pageSize);
        Task<int> GetTotalCountAsync();
        Task<TEntity> AddAsync(TEntity entity);
        Task<TEntity> UpdateAsync(TId id, TEntity entity);
        Task<TEntity> DeleteAsync(TId id);
        Task<IEnumerable<TEntity>> GetAllAsync();
    }
}
