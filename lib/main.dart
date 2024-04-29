import 'package:flutter/material.dart';
//import 'package:qr_project/pages/home.dart';
import 'package:qr_proyect/pages/home.dart';
//import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   //initilization of Firebase app
  
  // other Firebase service initialization
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 53, 49, 49)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
  
}