import 'package:flutter/material.dart';
import '../models/models.dart';
import '../utils/utils.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;

  const BookCard({
    Key? key,
    required this.book,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        title: Text(
          book.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),        subtitle: Text('${AppConstants.author} ${book.author}'),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: book.isAvailable ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            book.isAvailable ? AppConstants.available : AppConstants.borrowed,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
