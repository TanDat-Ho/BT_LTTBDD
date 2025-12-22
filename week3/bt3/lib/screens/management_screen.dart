import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import '../utils/utils.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({Key? key}) : super(key: key);

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {  final UserService _userService = UserServiceImpl();
  final BookService _bookService = BookServiceImpl();
  final TextEditingController _searchController = TextEditingController();
  
  List<Book> _borrowedBooks = [];
  User? _selectedUser;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    if (query.isEmpty) {
      setState(() {
        _selectedUser = null;
        _borrowedBooks = [];
      });
      return;
    }

    final foundUsers = _userService.search(query);
    if (foundUsers.isNotEmpty) {
      final user = foundUsers.first;
      setState(() {
        _selectedUser = user;
        _borrowedBooks = _userService.getBorrowedBooksByUser(
          user.id, 
          _bookService.getAll(),
        );
      });
    } else {
      setState(() {
        _selectedUser = null;
        _borrowedBooks = [];
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.managementTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppConstants.searchUserHint,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),            if (_selectedUser != null) ...[
              Text(
                '${AppConstants.currentUser} ${_selectedUser!.name}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),              Text(
                AppConstants.currentlyBorrowing,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
            ],
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showBorrowBookDialog(),
                    icon: Icon(Icons.add_circle_outline),
                    label: Text(AppConstants.borrowBook),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                if (_selectedUser != null) ...[
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _borrowedBooks.isNotEmpty ? () => _showReturnBookDialog() : null,
                      icon: Icon(Icons.remove_circle_outline),
                      label: Text(AppConstants.returnBook),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: _borrowedBooks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _selectedUser == null ? Icons.search : Icons.library_books,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),                          Text(
                            _selectedUser == null 
                              ? AppConstants.enterUserNameToSearch
                              : AppConstants.userHasNoBorrowedBooks,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _borrowedBooks.length,
                      itemBuilder: (context, index) {
                        return BookCard(
                          book: _borrowedBooks[index],
                          onTap: () => _showBookDetail(_borrowedBooks[index]),
                        );
                      },
                    ),
            ),
          ],
        ),      ),
    );
  }

  void _showBorrowBookDialog() {
    final availableBooks = _bookService.getAvailableBooks();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppConstants.selectBookToBorrow),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: availableBooks.isEmpty
              ? Center(child: Text(AppConstants.noResultsFound))
              : ListView.builder(
                  itemCount: availableBooks.length,
                  itemBuilder: (context, index) {
                    final book = availableBooks[index];
                    return ListTile(
                      title: Text(book.title),
                      subtitle: Text('${AppConstants.author} ${book.author}'),
                      onTap: () => _borrowBook(book),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppConstants.cancel),
          ),
        ],
      ),
    );
  }

  void _showReturnBookDialog() {
    if (_selectedUser == null || _borrowedBooks.isEmpty) return;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppConstants.returnBook),
        content: SizedBox(
          width: double.maxFinite,
          height: 200,
          child: ListView.builder(
            itemCount: _borrowedBooks.length,
            itemBuilder: (context, index) {
              final book = _borrowedBooks[index];
              return ListTile(
                title: Text(book.title),
                subtitle: Text('${AppConstants.author} ${book.author}'),
                onTap: () => _returnBook(book),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppConstants.cancel),
          ),
        ],
      ),
    );
  }

  void _borrowBook(Book book) {
    if (_selectedUser == null) return;
    
    final success = _userService.borrowBook(_selectedUser!.id, book.id);
    if (success) {
      _bookService.updateBookStatus(book.id, false);
      _refreshData();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppConstants.borrowSuccess}: ${book.title}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppConstants.borrowFailed)),
      );
    }
  }

  void _returnBook(Book book) {
    if (_selectedUser == null) return;
    
    final success = _userService.returnBook(_selectedUser!.id, book.id);
    if (success) {
      _bookService.updateBookStatus(book.id, true);
      _refreshData();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppConstants.returnSuccess}: ${book.title}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppConstants.returnFailed)),
      );
    }
  }

  void _refreshData() {
    if (_selectedUser != null) {
      setState(() {
        _selectedUser = _userService.getById(_selectedUser!.id);
        _borrowedBooks = _userService.getBorrowedBooksByUser(
          _selectedUser!.id, 
          _bookService.getAll(),
        );
      });
    }
  }

  void _showBookDetail(Book book) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(book.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,          children: [
            Text('${AppConstants.author} ${book.author}'),
            Text('${AppConstants.category} ${book.category}'),
            Text('${AppConstants.publishYear} ${book.publishYear}'),
            Text('${AppConstants.isbn} ${book.isbn}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppConstants.close),
          ),
        ],
      ),
    );
  }
}
