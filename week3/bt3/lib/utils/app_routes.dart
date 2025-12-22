import 'package:flutter/material.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const String home = '/';
  static const String management = '/management';
  static const String books = '/books';  static const String users = '/users';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => MainApp(),
    management: (context) => ManagementScreen(),
    books: (context) => BookListScreen(),
    users: (context) => UserListScreen(),
  };

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:  
        return MaterialPageRoute(builder: (context) => MainApp());
      case management:
        return MaterialPageRoute(builder: (context) => ManagementScreen());
      case books:
        return MaterialPageRoute(builder: (context) => BookListScreen());
      case users:
        return MaterialPageRoute(builder: (context) => UserListScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text('Không tìm thấy trang')),
            body: Center(
              child: Text('Trang không tồn tại'),
            ),
          ),
        );
    }
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ManagementScreen(),
    BookListScreen(),
    UserListScreen(),
  ];

  final List<BottomNavigationBarItem> _navigationItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Quản lý',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.library_books),
      label: 'Danh sách Sách',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: 'Người dùng',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hệ thống quản lý Thư viện',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.white,
        elevation: 8,
        items: _navigationItems,
      ),
    );
  }
}
