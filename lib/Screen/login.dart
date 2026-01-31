import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:uplaod_profile/Authentication/getx.dart';
import 'package:uplaod_profile/Components/button.dart';
import 'package:uplaod_profile/Components/textfield.dart';
import 'package:uplaod_profile/Screen/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController =TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: SingleChildScrollView(
         child: Container(
          width: 360,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white, // container background DIFFERENT from grey
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
          child: Column(

            children: 
            [
              const Text(
                'LoGin',
                 textAlign: TextAlign.center,
                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

              AppTextField(
                label: 'Email', 
                hint: 'jone@gmail.com',
                controller: emailController,
                ),

                const SizedBox(height: 16),

                AppTextField(label: 'Password', 
                hint: "Jone@132",
                obscureText: true,
                controller: passwordController,
                ),

                const SizedBox(height: 16),   
                  //Login Buttonn With GetX
              Obx(() =>
                AppButton(
                  text: authController.isLoading.value? 'Loding...' : 'Login',
                  color: Colors.blue[100], 
                onPressed: (){
                  authController.login(
                    email: emailController.text.trim(), 
                    password: passwordController.text.trim(),
                    );
                },),
              ),
              //Error message
               Obx(() =>authController.errorMessage.value.isEmpty?
               const SizedBox.shrink(): Text(
                  authController.errorMessage.value,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                )),

                  const SizedBox(height: 20.0),
                  GestureDetector(
                 onTap: () {
                    Get.to(()=> const Register()); //Navigate to Register wit Getx
                   },
                    child: const Text(
                            "Don't have an account? Register",
                            textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                         color: Colors.black,
                         decoration: TextDecoration.underline,
                           ),
                        ),
                      ),


                  const SizedBox(height: 16.0),  

                  Divider(),
                  const SizedBox(height: 16),

                  // Google and Facebook Icons 
                  AppButton(text: 'Login with Google', 
                  color: Colors.amber,
                  icon: Icons.g_mobiledata,
                  onPressed: (){
                      authController.loginWithGoogle();
                  },
                  ),

                  const SizedBox(height: 14.0),

                  AppButton(text: 'Login with Facebook', 
                  color: Colors.amber,
                  icon: Icons.facebook,
                  onPressed:(){
                    authController.loginWithFacebook();
                  },
                  ),
            ],
          ),
         ),
       ),
      ),
      
    );
  }
}