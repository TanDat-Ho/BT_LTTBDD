import 'base_model.dart';

/// User Model - Áp dụng đầy đủ các nguyên lý OOP
/// - INHERITANCE: Kế thừa từ BaseModel<User>
/// - POLYMORPHISM: Implement Searchable với logic riêng cho User  
/// - ENCAPSULATION: Private _id, business methods đóng gói
/// - ABSTRACTION: Hide implementation details, expose clean interface
class User extends BaseModel<User> implements Searchable {
  // Private field cho ID - OOP: ENCAPSULATION
  final String _id;
  
  // Public properties - User information
  final String name;                    // Tên người dùng
  final String email;                   // Email liên hệ
  final String phone;                   // Số điện thoại
  final List<String> borrowedBookIds;   // Danh sách ID sách đã mượn

  /// Constructor với validation - OOP: ENCAPSULATION
  /// Đóng gói validation logic và khởi tạo an toàn
  User({
    required String id,           // ID bắt buộc
    required this.name,          // Tên bắt buộc  
    required this.email,         // Email bắt buộc
    required this.phone,         // Phone bắt buộc
    this.borrowedBookIds = const [], // Default empty list
  }) : _id = id {
    // Validation trong constructor - Defensive programming
    if (!isValid()) throw ArgumentError('Invalid user data');
  }

  /// Getter cho private ID - OOP: ENCAPSULATION
  /// Controlled access to private data
  @override
  String get id => _id;

  /// Validation override - OOP: POLYMORPHISM
  /// User có validation rules riêng biệt với Book
  @override
  bool isValid() => _id.isNotEmpty && name.isNotEmpty && email.isNotEmpty;

  /// Search implementation cho User - OOP: POLYMORPHISM
  /// User search theo name, email, phone (khác với Book search)
  @override
  bool matchesSearchQuery(String query) {
    final q = query.toLowerCase();
    return name.toLowerCase().contains(q) ||
           email.toLowerCase().contains(q) ||
           phone.contains(query);
  }

  /// Business method: Mượn sách - OOP: ENCAPSULATION
  /// Đóng gói business logic trong model
  /// Returns new User object (Immutability pattern)
  User addBorrowedBook(String bookId) {
    // Business rule validation
    if (borrowedBookIds.contains(bookId)) {
      throw StateError('Book already borrowed');
    }
    // Return new object với updated data
    return copyWith(borrowedBookIds: [...borrowedBookIds, bookId]);
  }

  /// Business method: Trả sách - OOP: ENCAPSULATION  
  /// Đóng gói logic trả sách trong model
  User removeBorrowedBook(String bookId) {
    // Business rule validation
    if (!borrowedBookIds.contains(bookId)) {
      throw StateError('Book not borrowed');
    }
    // Filter out the returned book ID
    return copyWith(borrowedBookIds: 
        borrowedBookIds.where((id) => id != bookId).toList());
  }

  /// CopyWith implementation - Override từ BaseModel
  /// OOP: IMMUTABILITY + Factory Pattern
  /// Tạo User mới với một số properties được update
  @override
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    List<String>? borrowedBookIds,
  }) {
    return User(
      id: id ?? _id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      borrowedBookIds: borrowedBookIds ?? this.borrowedBookIds,
    );
  }

  /// ToString override - OOP: POLYMORPHISM
  /// Custom string representation cho debugging
  @override
  String toString() => 'User{$_id: $name}';
}
