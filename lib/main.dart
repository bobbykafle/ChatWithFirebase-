import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplaod_profile/Screen/login.dart';
import 'package:uplaod_profile/firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cheat Chat',
      theme: ThemeData(
       useMaterial3: true,
       textTheme: GoogleFonts.mochiyPopPOneTextTheme(),
      ),
      home: Login(),
    );
  }
}




