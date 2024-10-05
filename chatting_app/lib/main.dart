import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:chatting_app/screens/main_screen.dart';
import 'firebase_options.dart';

// import 'package:chatting_app/stream_builder_ex/counter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatting app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: LoginSignupScreen(),
    );
  }
}
