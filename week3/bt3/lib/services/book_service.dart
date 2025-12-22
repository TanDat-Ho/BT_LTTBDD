import '../models/models.dart';
import 'base_service.dart';

abstract class BookService extends BaseService<Book, String> {
  List<Book> getAvailableBooks();
  List<Book> getBorrowedBooks();
  bool updateBookStatus(String bookId, bool isAvailable);
}

class BookServiceImpl with Singleton<BookServiceImpl> implements BookService {
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
  List<Book> getAll() {
    return List.from(_books);
  }

  @override
  Book? getById(String id) {
    try {
      return _books.firstWhere((book) => book.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  void add(Book book) {
    if (!book.isValid()) {
      throw ArgumentError('Invalid book data');
    }
    _books.add(book);
    onItemAdded(book);
  }

  @override
  void update(Book book) {
    if (!book.isValid()) {
      throw ArgumentError('Invalid book data');
    }
    final index = _books.indexWhere((b) => b.id == book.id);
    if (index != -1) {
      _books[index] = book;
      onItemUpdated(book);
    }
  }

  @override
  void delete(String id) {
    _books.removeWhere((book) => book.id == id);
    onItemDeleted(id);
  }

  @override
  List<Book> search(String query) {
    if (query.isEmpty) return getAll();
    return _books.where((book) => book.matchesSearchQuery(query)).toList();
  }

  @override
  int count() => _books.length;

  @override
  bool exists(String id) => _books.any((book) => book.id == id);

  @override
  void clear() => _books.clear();

  @override
  List<Book> getAvailableBooks() {
    return _books.where((book) => book.isAvailable).toList();
  }

  @override
  List<Book> getBorrowedBooks() {
    return _books.where((book) => !book.isAvailable).toList();
  }

  @override
  bool updateBookStatus(String bookId, bool isAvailable) {
    final book = getById(bookId);
    if (book != null) {
      final updatedBook = book.copyWith(isAvailable: isAvailable);
      update(updatedBook);
      return true;
    }
    return false;
  }

  // Event callbacks implementation
  @override
  void onItemAdded(Book item) {
    // Log or notify when book is added
  }

  @override
  void onItemUpdated(Book item) {
    // Log or notify when book is updated
  }

  @override
  void onItemDeleted(String id) {
    // Log or notify when book is deleted
  }
}