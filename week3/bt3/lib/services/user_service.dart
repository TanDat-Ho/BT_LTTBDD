import '../models/models.dart';
import 'base_service.dart';

/// User Service Interface - OOP: ABSTRACTION  
/// Định nghĩa contract cho user operations
/// Extends BaseService để inherit CRUD operations
abstract class UserService extends BaseService<User, String> {
  /// Business-specific methods cho User domain
  List<Book> getBorrowedBooksByUser(String userId, List<Book> allBooks); // Lấy sách user đã mượn
  bool borrowBook(String userId, String bookId);  // Mượn sách
  bool returnBook(String userId, String bookId);  // Trả sách
}

/// User Service Implementation - OOP: INHERITANCE & SINGLETON
/// 
/// Implements UserService abstract class  
/// Quản lý business logic liên quan đến User và borrowing
class UserServiceImpl implements UserService {
  
  // Singleton Pattern - đảm bảo chỉ có 1 instance
  static final UserServiceImpl _instance = UserServiceImpl._internal();
  factory UserServiceImpl() => _instance;
  UserServiceImpl._internal();

  /// In-memory data storage - OOP: ENCAPSULATION
  /// Private list chứa sample users
  final List<User> _users = [
    // Sample data với một user đang mượn sách
    User(
      id: '1',
      name: 'Nguyễn Văn A',
      email: 'nguyenvana@gmail.com', 
      phone: '0123456789',
      borrowedBookIds: ['2'], // Đang mượn "Dart Programming"
    ),
    User(
      id: '2',
      name: 'Trần Thị B',
      email: 'tranthib@gmail.com',
      phone: '0987654321',
      // borrowedBookIds: [] - default empty
    ),
    User(
      id: '3', 
      name: 'Lê Văn C',
      email: 'levanc@gmail.com',
      phone: '0555666777',
      // borrowedBookIds: [] - default empty
    ),
  ];

  /// CRUD Operations Implementation - Override từ BaseService
  
  /// READ: Lấy tất cả users
  @override
  List<User> getAll() => List.from(_users); // Defensive copy

  /// READ: Tìm user theo ID - Safe navigation
  @override
  User? getById(String id) => 
      _users.cast<User?>().firstWhere((user) => user?.id == id, orElse: () => null);

  /// CREATE: Thêm user mới
  @override
  void add(User user) => _users.add(user);

  /// UPDATE: Cập nhật user - Find and replace pattern
  @override
  void update(User user) {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) _users[index] = user;
  }

  /// DELETE: Xóa user
  @override
  void delete(String id) => _users.removeWhere((user) => user.id == id);

  /// SEARCH: Tìm kiếm user - OOP: POLYMORPHISM
  /// Sử dụng matchesSearchQuery từ User model
  @override
  List<User> search(String query) =>
      query.isEmpty ? getAll() :
      _users.where((user) => user.matchesSearchQuery(query)).toList();

  /// Business Methods - Library domain logic
  
  /// Lấy danh sách sách mà user đã mượn
  /// Cross-reference giữa User.borrowedBookIds và Book list
  @override
  List<Book> getBorrowedBooksByUser(String userId, List<Book> allBooks) {
    final user = getById(userId);
    return user == null ? [] :  // Return empty nếu user not found
           allBooks.where((book) => user.borrowedBookIds.contains(book.id)).toList();
  }

  /// Business Logic: Mượn sách - OOP: ENCAPSULATION
  /// Encapsulate borrowing rules và validation
  @override
  bool borrowBook(String userId, String bookId) {
    final user = getById(userId);
    // Validation: user exists và chưa mượn book này
    if (user?.borrowedBookIds.contains(bookId) ?? true) return false;
    
    // Business operation: Add book to user's borrowed list
    // Sử dụng business method từ User model
    update(user!.addBorrowedBook(bookId));
    return true; // Success
  }

  /// Business Logic: Trả sách - OOP: ENCAPSULATION
  /// Encapsulate return rules và validation
  @override
  bool returnBook(String userId, String bookId) {
    final user = getById(userId);
    // Validation: user exists và đang mượn book này
    if (!(user?.borrowedBookIds.contains(bookId) ?? false)) return false;
    
    // Business operation: Remove book from user's borrowed list
    // Sử dụng business method từ User model
    update(user!.removeBorrowedBook(bookId));
    return true; // Success
  }
}
