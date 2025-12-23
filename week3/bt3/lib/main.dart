// Import các thư viện cần thiết
import 'package:flutter/material.dart';
import 'utils/utils.dart'; // Import tất cả utilities (constants, routes)

// Entry point của ứng dụng Flutter
void main() {
  runApp(LibraryManagementApp()); // Khởi chạy app
}

/// Main App Class - Áp dụng OOP: Encapsulation
/// Đóng gói toàn bộ cấu hình app trong một class
class LibraryManagementApp extends StatelessWidget {
  // Constructor với optional key parameter
  const LibraryManagementApp({Key? key}) : super(key: key);

  /// Build method - Override từ StatelessWidget (Inheritance)
  @override
  Widget build(BuildContext context) {
    // Return MaterialApp với theme và routing configuration
    return MaterialApp(
      // Sử dụng constants để đảm bảo consistency (OOP: Encapsulation)
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      
      // Theme configuration - Đóng gói styling logic
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,        // AppBar theme - Centralized styling
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        // Card theme - Consistent card styling across app
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // FloatingActionButton theme
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
        ),
      ),
      // Routing configuration - Sử dụng centralized routes (OOP: Organization)
      initialRoute: AppRoutes.home, // Route mặc định
      routes: AppRoutes.routes, // Các routes được định nghĩa sẵn
      onGenerateRoute: AppRoutes.generateRoute, // Dynamic route generation
    );
  }
}
