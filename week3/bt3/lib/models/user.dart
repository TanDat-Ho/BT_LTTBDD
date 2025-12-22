import 'base_model.dart';

class User extends BaseModel<User> implements Searchable {
  final String _id;
  final String name;
  final String email;
  final String phone;
  final List<String> borrowedBookIds;

  // Constructor với validation
  User({
    required String id,
    required this.name,
    required this.email,
    required this.phone,
    this.borrowedBookIds = const [],
  }) : _id = id {
    if (!isValid()) throw ArgumentError('Invalid user data');
  }

  @override
  String get id => _id;

  @override
  bool isValid() => _id.isNotEmpty && name.isNotEmpty && email.isNotEmpty;

  @override
  bool matchesSearchQuery(String query) {
    final q = query.toLowerCase();
    return name.toLowerCase().contains(q) ||
           email.toLowerCase().contains(q) ||
           phone.contains(query);
  }

  // Business methods
  User addBorrowedBook(String bookId) {
    if (borrowedBookIds.contains(bookId)) {
      throw StateError('Book already borrowed');
    }
    return copyWith(borrowedBookIds: [...borrowedBookIds, bookId]);
  }

  User removeBorrowedBook(String bookId) {
    if (!borrowedBookIds.contains(bookId)) {
      throw StateError('Book not borrowed');
    }
    return copyWith(borrowedBookIds: 
        borrowedBookIds.where((id) => id != bookId).toList());
  }

  @override
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    List<String>? borrowedBookIds,
  }) {
    return User(
      id: id ?? _id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      borrowedBookIds: borrowedBookIds ?? this.borrowedBookIds,
    );
  }

  @override
  String toString() => 'User{$_id: $name}';
}
