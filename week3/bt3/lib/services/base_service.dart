/// Base Service - Áp dụng OOP: ABSTRACTION & INHERITANCE
/// 
/// Template cho tất cả Services trong hệ thống
/// - Generic Type <T, ID> để tăng tính tái sử dụng (Reusability)
/// - Abstract class định nghĩa contract cho subclasses
/// - Template Method Pattern: Define skeleton, subclasses implement details
abstract class BaseService<T, ID> {
  
  /// CRUD Operations - Core business methods
  /// Tất cả services phải implement các method này
  
  /// Lấy tất cả items - READ operation
  List<T> getAll();
  
  /// Lấy item theo ID - READ operation  
  /// Return null nếu không tìm thấy
  T? getById(ID id);
  
  /// Thêm item mới - CREATE operation
  /// Subclass có thể add validation logic
  void add(T item);
  
  /// Cập nhật item existing - UPDATE operation
  /// Subclass tự implement update logic
  void update(T item);
  
  /// Xóa item theo ID - DELETE operation
  void delete(ID id);
  
  /// Tìm kiếm items theo query string - SEARCH operation
  /// Mỗi service sẽ có search logic khác nhau
  List<T> search(String query);
}

/// Searchable Interface - OOP: ABSTRACTION & POLYMORPHISM
/// 
/// Định nghĩa contract cho các entities có thể search được
/// Sử dụng khi cần search functionality nhưng implementation khác nhau
abstract class Searchable {
  /// Method để match với search query
  /// Mỗi class implement theo logic riêng:
  /// - Book: search theo title, author, category
  /// - User: search theo name, email, phone  
  bool matchesQuery(String query);
}
