import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplaod_profile/Authentication/auth_user.dart';
import 'package:uplaod_profile/Authentication/getx.dart';
import 'package:uplaod_profile/Screen/home.dart';
import 'package:uplaod_profile/Screen/login.dart';
import 'package:uplaod_profile/firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

//Inject AuthController Globally 
Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( //Import Change
      title: 'Cheat Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       useMaterial3: true,
       textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home:const AuthUser(), //Is a auth routhing
      getPages: [
        GetPage(name: '/login', page: ()=> const Login()),
        GetPage(name: '/home', page: ()=> const HomePage()),

      ],
    );
  }
}




