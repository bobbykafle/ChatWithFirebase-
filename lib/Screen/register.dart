import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:uplaod_profile/Authentication/getx.dart';
import 'package:uplaod_profile/Components/button.dart';
import 'package:uplaod_profile/Components/textfield.dart';
import 'package:uplaod_profile/Screen/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final AuthController authController = Get.find<AuthController>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 370,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
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
              mainAxisSize: MainAxisSize.min,
              children: [
                // Profile Picture placeholder
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.person, size: 50, color: Colors.grey.shade600),
                ),
                
                const SizedBox(height: 20),

                // First Name
                AppTextField(
                  label: 'Name',
                  hint: 'John',
                  controller: firstNameController,
                ),
                const SizedBox(height: 15),
                // Last Name
                AppTextField(
                  label: 'Last Name',
                  hint: 'Doe',
                  controller: lastNameController,
                ),
                const SizedBox(height: 15),

                // Email
                AppTextField(
                  label: 'Email',
                  hint: 'john@gmail.com',
                  controller: emailController,
                ),
                const SizedBox(height: 15),

                // Password
                AppTextField(
                  label: 'Password',
                  hint: '********',
                  obscureText: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 15),

                // Confirm Password
                AppTextField(
                  label: 'Confirm Password',
                  hint: '********',
                  obscureText: true,
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 18),

                // Register Button with GetX
                Obx(()=> AppButton(
                    text: authController.isLoading.value? 'Creating': 'Register',
                    color: Colors.blue[300],
                    onPressed: () {
                      authController.register(
                        firstName: firstNameController.text.trim(),
                         lastName: lastNameController.text.trim(),
                         email: emailController.text.trim(),
                         password: passwordController.text.trim(),
                         confirmPassword: confirmPasswordController.text.trim(),
                    );
                    },
                  ),
                ),
                 // Error message
                Obx(() => Text(
                      authController.errorMessage.value,
                      style:
                          const TextStyle(color: Colors.red, fontSize: 12),
                    )),




                const SizedBox(height: 20.0),
                                                                                       
                                                                                       
                GestureDetector(
                 onTap: () {
                       Get.offAll(()=> Login()
                    );
                   },
                    child: const Text(
                            'Already have an account? Login',
                            textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                         color: Colors.black,
                         decoration: TextDecoration.underline,
                           ),
                        ),
                      ),

                   
              ],
            ),
          ),
        ),
      ),
    );
  }
}