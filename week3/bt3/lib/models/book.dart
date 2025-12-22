import 'base_model.dart';

class Book extends BaseModel<Book> implements Searchable, StatusTrackable {
  final String _id;
  final String _title;
  final String _author;
  final String _category;
  final int _publishYear;
  final bool _isAvailable;
  final String _isbn;
  final DateTime _lastModified;

  // Constructor with validation
  Book({
    required String id,
    required String title,
    required String author,
    required String category,
    required int publishYear,
    required bool isAvailable,
    required String isbn,
    DateTime? lastModified,
  }) : _id = id,
       _title = title,
       _author = author,
       _category = category,
       _publishYear = publishYear,
       _isAvailable = isAvailable,
       _isbn = isbn,
       _lastModified = lastModified ?? DateTime.now() {
    if (!isValid()) {
      throw ArgumentError('Invalid book data provided');
    }
  }

  // Getters (Encapsulation)
  @override
  String get id => _id;
  String get title => _title;
  String get author => _author;
  String get category => _category;
  int get publishYear => _publishYear;
  bool get isAvailable => _isAvailable;
  String get isbn => _isbn;
  
  // StatusTrackable implementation
  @override
  bool get isActive => _isAvailable;
  @override
  DateTime get lastModified => _lastModified;

  // Validation (Business logic)
  @override
  bool isValid() {
    return _id.isNotEmpty &&
           _title.isNotEmpty &&
           _author.isNotEmpty &&
           _category.isNotEmpty &&
           _publishYear > 0 &&
           _isbn.isNotEmpty;
  }

  // Searchable implementation
  @override
  bool matchesSearchQuery(String query) {
    final lowerQuery = query.toLowerCase();
    return _title.toLowerCase().contains(lowerQuery) ||
           _author.toLowerCase().contains(lowerQuery) ||
           _category.toLowerCase().contains(lowerQuery) ||
           _isbn.toLowerCase().contains(lowerQuery);
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
    DateTime? lastModified,
  }) {
    return Book(
      id: id ?? _id,
      title: title ?? _title,
      author: author ?? _author,
      category: category ?? _category,
      publishYear: publishYear ?? _publishYear,
      isAvailable: isAvailable ?? _isAvailable,
      isbn: isbn ?? _isbn,
      lastModified: lastModified ?? _lastModified,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'title': _title,
      'author': _author,
      'category': _category,
      'publishYear': _publishYear,
      'isAvailable': _isAvailable,
      'isbn': _isbn,
      'lastModified': _lastModified.toIso8601String(),
    };
  }

  @override
  Book fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      category: json['category'],
      publishYear: json['publishYear'],
      isAvailable: json['isAvailable'],
      isbn: json['isbn'],
      lastModified: DateTime.parse(json['lastModified']),
    );
  }

  @override
  String toString() {
    return 'Book{id: $_id, title: $_title, author: $_author, isAvailable: $_isAvailable}';
  }
}
