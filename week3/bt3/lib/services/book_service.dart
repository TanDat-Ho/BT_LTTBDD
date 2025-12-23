import '../models/models.dart';
import 'base_service.dart';

/// Book Service Interface - OOP: ABSTRACTION
/// Định nghĩa contract cho book operations
/// Extends BaseService để inherit CRUD operations
abstract class BookService extends BaseService<Book, String> {
  /// Business-specific methods cho Book
  List<Book> getAvailableBooks();              // Lấy sách có sẵn
  bool updateBookStatus(String bookId, bool isAvailable); // Cập nhật trạng thái
}

/// Book Service Implementation - OOP: INHERITANCE & SINGLETON
/// 
/// Implements BookService abstract class
/// Áp dụng Singleton Pattern để đảm bảo only one instance
class BookServiceImpl implements BookService {
  
  // Singleton Pattern implementation
  // Static instance - chỉ tạo một lần duy nhất
  static final BookServiceImpl _instance = BookServiceImpl._internal();
  
  // Factory constructor - return existing instance
  factory BookServiceImpl() => _instance;
  
  // Private constructor - prevent external instantiation
  BookServiceImpl._internal();

  /// In-memory data storage - OOP: ENCAPSULATION
  /// Private list chứa sample data
  final List<Book> _books = [
    // Sample data - trong thực tế sẽ load từ database
    Book(
      id: '1',
      title: 'Flutter Development',
      author: 'John Doe',
      category: 'Technology',
      publishYear: 2023,
      isAvailable: true,
      isbn: '978-1234567890',
    ),
    Book(
      id: '2', 
      title: 'Dart Programming',
      author: 'Jane Smith',
      category: 'Technology',
      publishYear: 2022,
      isAvailable: false, // Đang được mượn
      isbn: '978-0987654321',
    ),
    Book(
      id: '3',
      title: 'Mobile App Design',
      author: 'Mike Johnson', 
      category: 'Design',
      publishYear: 2024,
      isAvailable: true,
      isbn: '978-1122334455',
    ),
  ];

  /// CRUD Operations Implementation - Override từ BaseService
  
  /// READ: Lấy tất cả sách
  @override
  List<Book> getAll() => List.from(_books); // Return copy để protect original data

  /// READ: Tìm sách theo ID - OOP: Error Handling
  @override
  Book? getById(String id) => 
      _books.cast<Book?>().firstWhere((book) => book?.id == id, orElse: () => null);

  /// CREATE: Thêm sách mới
  @override
  void add(Book book) => _books.add(book);

  /// UPDATE: Cập nhật sách - OOP: ENCAPSULATION
  /// Find by ID và replace in list
  @override
  void update(Book book) {
    final index = _books.indexWhere((b) => b.id == book.id);
    if (index != -1) _books[index] = book; // Replace existing
  }

  /// DELETE: Xóa sách theo ID
  @override
  void delete(String id) => _books.removeWhere((book) => book.id == id);

  /// SEARCH: Tìm kiếm sách - OOP: POLYMORPHISM
  /// Sử dụng matchesSearchQuery method từ Book model
  @override
  List<Book> search(String query) =>
      query.isEmpty ? getAll() : 
      _books.where((book) => book.matchesSearchQuery(query)).toList();

  /// Business Methods - Specific cho Book domain
  
  /// Lấy danh sách sách có sẵn (chưa được mượn)
  @override
  List<Book> getAvailableBooks() =>
      _books.where((book) => book.isAvailable).toList();

  /// Cập nhật trạng thái sách (mượn/trả) - Business Logic
  /// Returns true nếu success, false nếu book not found
  @override
  bool updateBookStatus(String bookId, bool isAvailable) {
    final book = getById(bookId);
    if (book != null) {
      // Sử dụng copyWith để tạo updated book (Immutability)
      update(book.copyWith(isAvailable: isAvailable));
      return true;
    }
    return false; // Book not found
  }
}