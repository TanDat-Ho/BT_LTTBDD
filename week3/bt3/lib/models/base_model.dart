/// Base Model - Áp dụng nguyên lý OOP: ABSTRACTION
/// Định nghĩa interface chung cho tất cả models trong hệ thống
/// Sử dụng Generic Type <T> để tăng tính tái sử dụng (Reusability)
abstract class BaseModel<T> {
  // Abstract getter - Bắt buộc các subclass phải implement
  String get id;
  
  /// Abstract methods - Template Method Pattern
  /// Các subclass phải implement các method này
  T copyWith(); // Tạo bản copy với thay đổi
  bool isValid(); // Validation logic
  
  /// Operator overriding - So sánh objects dựa trên ID
  /// OOP: Polymorphism - cùng operator nhưng behavior khác nhau
  @override
  bool operator ==(Object other) => 
      other is BaseModel && other.id == id;
  
  /// HashCode override - Cần thiết khi override ==
  @override
  int get hashCode => id.hashCode;
}

/// Interface cho khả năng tìm kiếm - OOP: ABSTRACTION & POLYMORPHISM
/// Các class implement interface này có thể search theo cách khác nhau
abstract class Searchable {
  /// Method abstract cho tìm kiếm
  /// Mỗi class sẽ implement logic search riêng biệt
  bool matchesSearchQuery(String query);
}
