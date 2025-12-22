// Base Service - OOP với tính kế thừa và trừu tượng
abstract class BaseService<T, ID> {
  List<T> getAll();
  T? getById(ID id);
  void add(T item);
  void update(T item);
  void delete(ID id);
  List<T> search(String query);
}

// Searchable interface - Đa hình
abstract class Searchable {
  bool matchesQuery(String query);
}
