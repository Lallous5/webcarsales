import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAaJHqxYYdDbmYKqQ6dG0yopFTpCKya4PY",
      authDomain: "carsales-154f0.firebaseapp.com",
      projectId: "carsales-154f0",
      storageBucket: "carsales-154f0.appspot.com",
      messagingSenderId: "40244781477",
      appId: "1:40244781477:web:610195358eeb859cd5084c",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cars Dealer',
      theme: ThemeData(
          useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(background: const Color(0xFF161A25))),
      home: const HomePage(),
    );
  }
}
