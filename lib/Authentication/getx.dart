import 'package:get/get.dart';
import 'package:uplaod_profile/Authentication/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uplaod_profile/Screen/home.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  final Auth _auth = Auth();

  //Reactive  Firebase user
  Rx<User?> user = Rx<User?>(null);
  Rx<XFile?> pickedImage = Rx<XFile?>(null);
 RxBool isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit(){
    super.onInit();
    user.bindStream(_auth.authStateChanges); //helps to bind Firebase auth stream to user
    

    //Stop Loading once user value upadtes
    ever<User?>(user, (_) => isLoading.value = false);
  }

  // LOGIN
  Future<void> login({required String email, required String password}) async {
    if(email.trim().isEmpty || password.trim().isEmpty){
      errorMessage.value = "Please fill the fields";
       return; // stop execution
    }
    if(!email.contains('@')){
      errorMessage.value = "Invalid email format";
      return;
    }
    if(password.length<8){
      errorMessage.value = "Password must be at least 8 characters";
      return;
    }
    // Call the Auth clas
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    isLoading.value = false;
    // Handle resust
    if (result != null) {
      errorMessage.value = result; //show firebase error like "User not foound"
      Get.snackbar('Login Failed', result);
    } else {
      Get.snackbar('Success', 'Logged in successfully');
      Get.offAll(HomePage());
    }
  }

  // REGISTER
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if(firstName.trim().isEmpty || lastName.trim().isEmpty || email.trim().isEmpty || password.trim().isEmpty || confirmPassword.trim().isEmpty){
      errorMessage.value ="Please fill the fields";
      return;
    }
    if(!email.contains('@')){
      errorMessage.value = "Invalid email format";
      return;
    }
    if(password.length<8){
      errorMessage.value = "Password must be at least 8 characters";
    }
    if(password != confirmPassword){
      errorMessage.value = "Password do not match";
      return;
    }
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _auth.createUser(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    isLoading.value = false;

    if (result != null) {
      errorMessage.value = result;
      Get.snackbar('Registration Failed', result);
    } else {
      Get.snackbar('Success', 'Account created');
       Get.offAll(HomePage());
    }
  }

  // GOOGLE
  Future<void> loginWithGoogle() async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _auth.signInWithGoogle();

    isLoading.value = false;

    if (result != null) {
      errorMessage.value = result;
    } else {
    errorMessage.value = 'NO';
    Get.offAll(HomePage());
    }
  }

  // FACEBOOK
  Future<void> loginWithFacebook() async {
    isLoading.value = true;

    final result = await _auth.signInWithFacebook();

    isLoading.value = false;

    if (result != null) {
      Get.snackbar('Facebook Login Failed', result);
    } else {
      Get.snackbar('Success', 'Logged in with Facebook');
    }
  }

  Future<void> logout() async {
    await signOut();
    Get.offAllNamed('/login');
  }

  // Upload profile
  Future<void> pickProfileImage() async{
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source:ImageSource.gallery);
    if(image != null){
       pickedImage.value = image;

    }
  }
  
}
