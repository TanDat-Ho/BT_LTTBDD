import 'base_model.dart';

class User extends BaseModel<User> implements Searchable, StatusTrackable {
  final String _id;
  final String _name;
  final String _email;
  final String _phone;
  final List<String> _borrowedBookIds;
  final DateTime _lastModified;

  // Constructor with validation
  User({
    required String id,
    required String name,
    required String email,
    required String phone,
    List<String>? borrowedBookIds,
    DateTime? lastModified,
  }) : _id = id,
       _name = name,
       _email = email,
       _phone = phone,
       _borrowedBookIds = borrowedBookIds ?? [],
       _lastModified = lastModified ?? DateTime.now() {
    if (!isValid()) {
      throw ArgumentError('Invalid user data provided');
    }
  }

  // Getters (Encapsulation)
  @override
  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  List<String> get borrowedBookIds => List.unmodifiable(_borrowedBookIds);
  
  // StatusTrackable implementation
  @override
  bool get isActive => true; // Users are always active unless deleted
  @override
  DateTime get lastModified => _lastModified;

  // Business logic methods
  int get borrowedBooksCount => _borrowedBookIds.length;
  bool get hasBorrowedBooks => _borrowedBookIds.isNotEmpty;
  bool canBorrowMoreBooks({int maxBooks = 5}) => _borrowedBookIds.length < maxBooks;

  // Validation (Business logic)
  @override
  bool isValid() {
    return _id.isNotEmpty &&
           _name.isNotEmpty &&
           _email.isNotEmpty &&
           _isValidEmail(_email) &&
           _phone.isNotEmpty;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Searchable implementation
  @override
  bool matchesSearchQuery(String query) {
    final lowerQuery = query.toLowerCase();
    return _name.toLowerCase().contains(lowerQuery) ||
           _email.toLowerCase().contains(lowerQuery) ||
           _phone.contains(query);
  }

  // Business logic for borrowing
  User addBorrowedBook(String bookId) {
    if (_borrowedBookIds.contains(bookId)) {
      throw StateError('Book already borrowed by this user');
    }
    final newBorrowedIds = List<String>.from(_borrowedBookIds)..add(bookId);
    return copyWith(borrowedBookIds: newBorrowedIds, lastModified: DateTime.now());
  }

  User removeBorrowedBook(String bookId) {
    if (!_borrowedBookIds.contains(bookId)) {
      throw StateError('Book not borrowed by this user');
    }
    final newBorrowedIds = List<String>.from(_borrowedBookIds)..remove(bookId);
    return copyWith(borrowedBookIds: newBorrowedIds, lastModified: DateTime.now());
  }

  @override
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    List<String>? borrowedBookIds,
    DateTime? lastModified,
  }) {
    return User(
      id: id ?? _id,
      name: name ?? _name,
      email: email ?? _email,
      phone: phone ?? _phone,
      borrowedBookIds: borrowedBookIds ?? _borrowedBookIds,
      lastModified: lastModified ?? _lastModified,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'email': _email,
      'phone': _phone,
      'borrowedBookIds': _borrowedBookIds,
      'lastModified': _lastModified.toIso8601String(),
    };
  }

  @override
  User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      borrowedBookIds: List<String>.from(json['borrowedBookIds'] ?? []),
      lastModified: DateTime.parse(json['lastModified']),
    );
  }

  @override
  String toString() {
    return 'User{id: $_id, name: $_name, borrowedBooks: ${_borrowedBookIds.length}}';
  }
}
