import 'base_model.dart';

class Book extends BaseModel<Book> implements Searchable {
  final String _id;
  final String title;
  final String author;
  final String category;
  final int publishYear;
  final bool isAvailable;
  final String isbn;

  // Constructor với validation
  Book({
    required String id,
    required this.title,
    required this.author,
    required this.category,
    required this.publishYear,
    required this.isAvailable,
    required this.isbn,
  }) : _id = id {
    if (!isValid()) throw ArgumentError('Invalid book data');
  }

  @override
  String get id => _id;

  @override
  bool isValid() => 
      _id.isNotEmpty && title.isNotEmpty && author.isNotEmpty;

  @override
  bool matchesSearchQuery(String query) {
    final q = query.toLowerCase();
    return title.toLowerCase().contains(q) ||
           author.toLowerCase().contains(q) ||
           category.toLowerCase().contains(q);
  }

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
      id: id ?? _id,
      title: title ?? this.title,
      author: author ?? this.author,
      category: category ?? this.category,
      publishYear: publishYear ?? this.publishYear,
      isAvailable: isAvailable ?? this.isAvailable,
      isbn: isbn ?? this.isbn,
    );
  }

  @override
  String toString() => 'Book{$_id: $title by $author}';
}
