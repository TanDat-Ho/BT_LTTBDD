import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title = 'Hello my friend!';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    height: 100,
                    width: double.infinity,
                    child: Center(
                      child: Text('My First app', style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ),
                
                Expanded(
                  child: Container(
                   color: Colors.white,
                   height: 100,
                   width: double.infinity,
                   child: Center(
                     child: Text(title, style: TextStyle(fontSize: 24)),
                   ),
                 ),
               ),

                 Expanded(
                  child: Container(
                   color: Colors.white,
                   height: 100,
                   width: double.infinity,
                   child: Center(
                     child: TextButton(onPressed: () {
                      setState(() {
                        title = title == 'Hello my friend!' ? 'I\'m Ho Tan Dat' : 'Hello my friend!';
                      });
                     }, 
                     child: Text('Say hi!'), 
                     style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue), 
                     fixedSize: MaterialStateProperty.all(Size(150, 50))) ),
                   ),
                 )),
               ],
             ),
            )
      
    );
  }
}
