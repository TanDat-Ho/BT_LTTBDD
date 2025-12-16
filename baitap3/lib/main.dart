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
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String? errorText;
  String result = "";

  // Hàm thực hiện phép tính
  void _calculate(String operation) {
    setState(() {
      // Reset error text
      errorText = null;

      // Kiểm tra input
      double? num1 = double.tryParse(_controller1.text);
      double? num2 = double.tryParse(_controller2.text);

      if (num1 == null || num2 == null) {
        errorText = 'Vui lòng nhập số hợp lệ';
        result = "";
        return;
      }

      // Thực hiện phép tính
      double calcResult;
      switch (operation) {
        case '+':
          calcResult = num1 + num2;
          result = "${calcResult.toStringAsFixed(1)}";
          break;
        case '-':
          calcResult = num1 - num2;
          result = "${calcResult.toStringAsFixed(1)}";
          break;
        case '*':
          calcResult = num1 * num2;
          result = "${calcResult.toStringAsFixed(1)}";
          break;
        case '/':
          if (num2 == 0) {
            errorText = 'Không thể chia cho 0';
            result = "";
            return;
          }
          calcResult = num1 / num2;
          result = "${calcResult.toStringAsFixed(2)}";
          break;
        default:
          result = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Thực hành số 03",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Nhập vào số 1',
                        errorText: errorText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => _calculate('+'),
                    icon: Icon(Icons.add), 
                    iconSize: 30,
                    color: Colors.white, 
                    style: IconButton.styleFrom(backgroundColor: Colors.redAccent),
                    padding: EdgeInsets.all(20),
                  ),

                  IconButton(
                    onPressed: () => _calculate('-'),
                    icon: Icon(Icons.remove), 
                    iconSize: 30,
                    color: Colors.white,
                    style: IconButton.styleFrom(backgroundColor: Colors.blueAccent),
                    padding: EdgeInsets.all(20),
                  ),

                  IconButton(
                    onPressed: () => _calculate('*'),
                    icon: Icon(Icons.close), 
                    iconSize: 30,
                    color: Colors.white, 
                    style: IconButton.styleFrom(backgroundColor: Colors.purpleAccent),
                    padding: EdgeInsets.all(20),
                  ),

                  IconButton(
                    onPressed: () => _calculate('/'),
                    icon: Icon(Icons.percent), // Updated icon
                    iconSize: 30,
                    color: Colors.white, 
                    style: IconButton.styleFrom(backgroundColor: Colors.black),
                    padding: EdgeInsets.all(20),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Nhập vào số 2',
                        errorText: errorText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Text(
                      result.isEmpty ? "Kết quả:" :  "Kết quả: $result",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: result.isEmpty ? Colors.white : Colors.black,
                      ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}