// Base Service with generic types và OOP principles
abstract class BaseService<T, ID> {
  // Core CRUD operations
  List<T> getAll();
  T? getById(ID id);
  void add(T item);
  void update(T item);
  void delete(ID id);
  List<T> search(String query);
  
  // Additional utility methods
  int count();
  bool exists(ID id);
  void clear();
  
  // Event callbacks (Observer pattern)
  void onItemAdded(T item) {}
  void onItemUpdated(T item) {}
  void onItemDeleted(ID id) {}
}

// Repository pattern for data access
abstract class DataRepository<T, ID> {
  Future<List<T>> findAll();
  Future<T?> findById(ID id);
  Future<void> save(T item);
  Future<void> deleteById(ID id);
  Future<List<T>> findByQuery(String query);
}

// Cache interface
abstract class Cacheable<T, ID> {
  void cacheItem(ID id, T item);
  T? getCachedItem(ID id);
  void invalidateCache(ID id);
  void clearCache();
}

// Singleton mixin - simplified implementation
mixin Singleton<T> {
  // This mixin just provides the singleton pattern structure
  // Each implementing class should handle its own instance
}
