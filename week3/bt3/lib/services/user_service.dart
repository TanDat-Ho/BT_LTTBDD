import '../models/models.dart';
import 'base_service.dart';

abstract class UserService extends BaseService<User, String> {
  List<Book> getBorrowedBooksByUser(String userId, List<Book> allBooks);
  bool borrowBook(String userId, String bookId);
  bool returnBook(String userId, String bookId);
}

class UserServiceImpl implements UserService {
  static final UserServiceImpl _instance = UserServiceImpl._internal();
  factory UserServiceImpl() => _instance;
  UserServiceImpl._internal();

  final List<User> _users = [
    User(
      id: '1',
      name: 'Nguyễn Văn A',
      email: 'nguyenvana@gmail.com',
      phone: '0123456789',
      borrowedBookIds: ['2'],
    ),
    User(
      id: '2',
      name: 'Trần Thị B',
      email: 'tranthib@gmail.com',
      phone: '0987654321',
    ),
    User(
      id: '3',
      name: 'Lê Văn C',
      email: 'levanc@gmail.com',
      phone: '0555666777',
    ),
  ];

  @override
  List<User> getAll() => List.from(_users);

  @override
  User? getById(String id) => 
      _users.cast<User?>().firstWhere((user) => user?.id == id, orElse: () => null);

  @override
  void add(User user) => _users.add(user);

  @override
  void update(User user) {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) _users[index] = user;
  }

  @override
  void delete(String id) => _users.removeWhere((user) => user.id == id);

  @override
  List<User> search(String query) =>
      query.isEmpty ? getAll() :
      _users.where((user) => user.matchesSearchQuery(query)).toList();

  @override
  List<Book> getBorrowedBooksByUser(String userId, List<Book> allBooks) {
    final user = getById(userId);
    return user == null ? [] : 
           allBooks.where((book) => user.borrowedBookIds.contains(book.id)).toList();
  }

  @override
  bool borrowBook(String userId, String bookId) {
    final user = getById(userId);
    if (user?.borrowedBookIds.contains(bookId) ?? true) return false;
    update(user!.addBorrowedBook(bookId));
    return true;
  }

  @override
  bool returnBook(String userId, String bookId) {
    final user = getById(userId);
    if (!(user?.borrowedBookIds.contains(bookId) ?? false)) return false;
    update(user!.removeBorrowedBook(bookId));
    return true;
  }
}
