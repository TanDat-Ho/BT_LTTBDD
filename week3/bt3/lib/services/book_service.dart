import '../models/models.dart';
import 'base_service.dart';

abstract class BookService extends BaseService<Book, String> {
  List<Book> getAvailableBooks();
  bool updateBookStatus(String bookId, bool isAvailable);
}

class BookServiceImpl implements BookService {
  static final BookServiceImpl _instance = BookServiceImpl._internal();
  factory BookServiceImpl() => _instance;
  BookServiceImpl._internal();

  final List<Book> _books = [
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
      isAvailable: false,
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

  @override
  List<Book> getAll() => List.from(_books);

  @override
  Book? getById(String id) => 
      _books.cast<Book?>().firstWhere((book) => book?.id == id, orElse: () => null);

  @override
  void add(Book book) => _books.add(book);

  @override
  void update(Book book) {
    final index = _books.indexWhere((b) => b.id == book.id);
    if (index != -1) _books[index] = book;
  }

  @override
  void delete(String id) => _books.removeWhere((book) => book.id == id);

  @override
  List<Book> search(String query) =>
      query.isEmpty ? getAll() : 
      _books.where((book) => book.matchesSearchQuery(query)).toList();

  @override
  List<Book> getAvailableBooks() =>
      _books.where((book) => book.isAvailable).toList();

  @override
  bool updateBookStatus(String bookId, bool isAvailable) {
    final book = getById(bookId);
    if (book != null) {
      update(book.copyWith(isAvailable: isAvailable));
      return true;
    }
    return false;
  }
}