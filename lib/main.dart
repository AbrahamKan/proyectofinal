import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyectofinal/config/firebase_options.dart';
import 'app.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // firebase setup
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //run app
  runApp(MyApp());
}

