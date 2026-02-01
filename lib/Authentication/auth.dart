import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Auth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //Sign In
  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  })async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
       password: password,
       );
       return null;
      } on FirebaseAuthException catch (e){
        return e.message ?? "Login Failed";
      }
  }

  Future<String?> createUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async{
    
     try{
     UserCredential userCredential =
     await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password,
     );
      
      //set Name only no porfile 
      await userCredential.user!.updateDisplayName(
        "$firstName $lastName",
      );
      await userCredential.user!.reload();
      return null; 
   
     }on FirebaseAuthException catch (e){
      return e.message ;
  }
     

  }

   //Change profile photo anytime
   Future<void> updateProfilePhoto(String imageUrl) async{
    final user = _firebaseAuth.currentUser;
    if(user == null) return;
    await user.updatePhotoURL(imageUrl);
    await user.reload();
   }

   //udtatte both photot and name together
   Future<void> updateProfile({String? name, String? photoUrl}) async{
    final user = _firebaseAuth.currentUser;
    if(user == null) return;
    if(name != null) await user.updateDisplayName(name);
    if(photoUrl != null) await user.updatePhotoURL(photoUrl);

    await user.reload();
   }


  // SignIn with Google
         Future<String?> signInWithGoogle() async {
  try {
    final googleSignIn = GoogleSignIn.instance;

    final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();
    if (googleUser == null) return 'Google sign-in cancelled';

    // Get authentication tokens
    final googleAuth = await googleUser.authentication;

    if (googleAuth.idToken == null) {
      return 'Failed to get Google credentials';
    }

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    return null; // success
  } on FirebaseAuthException catch (e) {
    return e.message;
  } catch (e) {
    return e.toString();
  }
}

    //faebook
    Future<String?> signInWithFacebook() async {
       try {
      // Trigger Facebook login
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
       
        final accessToken = result.accessToken?.tokenString;
        if (accessToken == null) return "Failed to get Facebook token";

      
        final credential = FacebookAuthProvider.credential(accessToken);

      
        await _firebaseAuth.signInWithCredential(credential);
        return null; 
      } else if (result.status == LoginStatus.cancelled) {
        return "Facebook sign-in cancelled";
      } else {
        return "Facebook sign-in failed: ${result.message}";
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}

  


//SIGNOUT

Future<void> signOut() async {
  try {
    // Firebase sign out
    await FirebaseAuth.instance.signOut();

    // Google sign out
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.signOut();
    

    // Facebook sign out
    await FacebookAuth.instance.logOut();

    print("User fully signed out!");
  } 
  catch (e) {
    print("Error signing out: $e");
  }

}