import '../models/models.dart';
import 'base_service.dart';

abstract class UserService extends BaseService<User, String> {
  List<Book> getBorrowedBooksByUser(String userId, List<Book> allBooks);
  bool borrowBook(String userId, String bookId);
  bool returnBook(String userId, String bookId);
}

class UserServiceImpl with Singleton<UserServiceImpl> implements UserService {
  static final UserServiceImpl _instance = UserServiceImpl._internal();
  factory UserServiceImpl() => _instance;
  UserServiceImpl._internal();

  final List<User> _users = [
    User(
      id: '1',
      name: 'Nguyễn Văn A',
      email: 'nguyenvana@gmail.com',
      phone: '0123456789',
      borrowedBookIds: ['2'], // Đang mượn sách Dart Programming
    ),
    User(
      id: '2',
      name: 'Trần Thị B',
      email: 'tranthib@gmail.com',
      phone: '0987654321',
      borrowedBookIds: [],
    ),
    User(
      id: '3',
      name: 'Lê Văn C',
      email: 'levanc@gmail.com',
      phone: '0555666777',
      borrowedBookIds: [],
    ),
  ];

  @override
  List<User> getAll() {
    return List.from(_users);
  }

  @override
  User? getById(String id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  void add(User user) {
    _users.add(user);
  }

  @override
  void update(User user) {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
    }
  }

  @override
  void delete(String id) {
    _users.removeWhere((user) => user.id == id);
  }

  @override
  List<User> search(String query) {
    return _users.where((user) => 
      user.name.toLowerCase().contains(query.toLowerCase()) ||
      user.email.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
  @override
  List<Book> getBorrowedBooksByUser(String userId, List<Book> allBooks) {
    final user = getById(userId);
    if (user == null) return [];
    
    return allBooks.where((book) => 
      user.borrowedBookIds.contains(book.id)
    ).toList();
  }
  @override
  bool borrowBook(String userId, String bookId) {
    final user = getById(userId);
    if (user == null || user.borrowedBookIds.contains(bookId)) {
      return false;
    }
    
    final updatedUser = user.addBorrowedBook(bookId);
    update(updatedUser);
    return true;
  }

  @override
  bool returnBook(String userId, String bookId) {
    final user = getById(userId);
    if (user == null || !user.borrowedBookIds.contains(bookId)) {
      return false;
    }
    
    final updatedUser = user.removeBorrowedBook(bookId);
    update(updatedUser);
    return true;
  }

  // Implement missing BaseService methods
  @override
  int count() => _users.length;

  @override
  bool exists(String id) => _users.any((user) => user.id == id);

  @override
  void clear() => _users.clear();

  // Event callbacks implementation
  @override
  void onItemAdded(User item) {
    // Log or notify when user is added
  }

  @override
  void onItemUpdated(User item) {
    // Log or notify when user is updated
  }

  @override
  void onItemDeleted(String id) {
    // Log or notify when user is deleted
  }
}
