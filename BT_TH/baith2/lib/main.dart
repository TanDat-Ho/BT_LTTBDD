import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _emailController = TextEditingController(); // Thêm controller
  String? errorText; // Biến lưu thông báo lỗi
  String? successText; // Biến lưu thông báo thành công

  // Hàm kiểm tra email hợp lệ
  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  void _checkEmail() {
    setState(() {
      String email = _emailController.text.trim(); // Lấy text từ controller
      
      if (email.isEmpty) {
        errorText = 'Vui lòng nhập địa chỉ email';
        successText = null;
      } else if (_isValidEmail(email)) {
        errorText = null;
        successText = 'Địa chỉ email hợp lệ';
        print('Địa chỉ email hợp lệ: $email');
      } else {
        errorText = 'Địa chỉ email không hợp lệ';
        successText = null;
        print('Địa chỉ email không hợp lệ: $email');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Thực hành 02",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  
                  TextField(
                    controller: _emailController, // Gán controller
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: errorText, // Hiển thị lỗi
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Hiển thị thông báo thành công
                  if (successText != null)
                    Text(
                      successText!,
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _checkEmail, // Gọi hàm kiểm tra
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Kiểm tra",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
