import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snack bar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // home: const MyPage(),
      home: const MyColRow(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(
          color: Colors.red,
          width: 100,
          height: 100,
          margin: const EdgeInsets.symmetric(
            vertical: 80.0,
            horizontal: 20.0,
          ),
          padding: const EdgeInsets.all(20.0),
          child: const Text(
            'Hello',
            style: TextStyle(
              backgroundColor: Colors.green,
            )
          ),
        ),
      )
    );
  }
}

class MyColRow extends StatelessWidget {
  const MyColRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.white,
                child: const Text('Container 1'),
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: const Text('Container 2'),
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: const Text('Container 3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
