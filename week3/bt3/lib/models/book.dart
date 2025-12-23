import 'base_model.dart';

/// Book Model - Áp dụng OOP: INHERITANCE & POLYMORPHISM
/// - INHERITANCE: Kế thừa từ BaseModel<Book>
/// - POLYMORPHISM: Implement interface Searchable theo cách riêng
/// - ENCAPSULATION: Private field _id, public properties
class Book extends BaseModel<Book> implements Searchable {
  // Private field cho ID - OOP: ENCAPSULATION
  final String _id;
  
  // Public properties - Business data
  final String title;      // Tên sách
  final String author;     // Tác giả  
  final String category;   // Thể loại
  final int publishYear;   // Năm xuất bản
  final bool isAvailable;  // Trạng thái có sẵn
  final String isbn;       // Mã ISBN

  /// Constructor với validation - OOP: ENCAPSULATION
  /// Đóng gói logic validation trong constructor
  Book({
    required String id,        // ID bắt buộc
    required this.title,       // Tên sách bắt buộc
    required this.author,      // Tác giả bắt buộc
    required this.category,    // Thể loại bắt buộc
    required this.publishYear, // Năm xuất bản bắt buộc
    required this.isAvailable, // Trạng thái bắt buộc
    required this.isbn,        // ISBN bắt buộc
  }) : _id = id {
    // Validation trong constructor - Fail fast principle
    if (!isValid()) throw ArgumentError('Invalid book data');
  }

  /// Getter cho ID - OOP: ENCAPSULATION
  /// Cung cấp read-only access cho private field
  @override
  String get id => _id;

  /// Validation method - Override từ BaseModel
  /// OOP: POLYMORPHISM - mỗi model có validation logic riêng
  @override
  bool isValid() => 
      _id.isNotEmpty && title.isNotEmpty && author.isNotEmpty;

  /// Search implementation - Override từ Searchable interface
  /// OOP: POLYMORPHISM - Book có logic search riêng biệt  
  @override
  bool matchesSearchQuery(String query) {
    final q = query.toLowerCase();
    return title.toLowerCase().contains(q) ||
           author.toLowerCase().contains(q) ||
           category.toLowerCase().contains(q);
  }

  /// CopyWith method - Override từ BaseModel
  /// OOP: IMMUTABILITY - Tạo object mới thay vì modify existing
  /// Factory Pattern - Tạo object với một số thuộc tính thay đổi
  @override
  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? category,
    int? publishYear,
    bool? isAvailable,
    String? isbn,
  }) {
    return Book(
      id: id ?? _id,                           // Giữ nguyên nếu null
      title: title ?? this.title,              // Sử dụng giá trị mới nếu có
      author: author ?? this.author,
      category: category ?? this.category,
      publishYear: publishYear ?? this.publishYear,
      isAvailable: isAvailable ?? this.isAvailable,
      isbn: isbn ?? this.isbn,
    );
  }

  /// ToString override - Debug và logging
  /// OOP: POLYMORPHISM - Custom string representation
  @override
  String toString() => 'Book{$_id: $title by $author}';
}
