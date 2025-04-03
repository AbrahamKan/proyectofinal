import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyectofinal/features/auth/data/firebase_auth_repo.dart';
import 'package:proyectofinal/features/auth/presentation/pages/login_page.dart';
import 'package:proyectofinal/features/auth/presentation/pages/register_page.dart';
import 'package:proyectofinal/firebase_options.dart';
import 'package:proyectofinal/themes/light_mode.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // firebase setup
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //run app
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: RegisterPage(),
    );
  }
}