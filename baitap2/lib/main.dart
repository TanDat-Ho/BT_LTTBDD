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
  final TextEditingController _controller = TextEditingController();
  String? errorText;
  List<String> items = [];

  void _handleCreateItems() {
    if (int.tryParse(_controller.text) == null || _controller.text.isEmpty) {
      setState(() {
        errorText = 'Dữ liệu bạn nhập không hợp lệ';
        items = [];
      });
    } else {
      int count = int.parse(_controller.text);
      if (count <= 0) {
        setState(() {
          errorText = 'Số lượng phải lớn hơn 0';
          items = [];
        });
      } else {
        setState(() {
          errorText = null;
          items = List.generate(count, (index) => '${index + 1}');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Thực hành số 02",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nhập vào số lượng',
                          errorText: errorText,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(width: 10),

                    ElevatedButton(
                      onPressed: _handleCreateItems,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 38, 0, 255),
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      ),
                      child: Text('Tạo', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Hiển thị danh sách các item được tạo
                if (items.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          color: Color.fromARGB(255, 173, 56, 56),
                          child: ListTile(
                            title: Text(
                              items[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
