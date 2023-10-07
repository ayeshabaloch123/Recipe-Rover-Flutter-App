import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e);
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e);
    }
  }

  signOut() async {
    await firebaseAuth.signOut();
  }

  Future<Map<String, dynamic>?> getUserDetails(String email) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection("Users")
              .where("email", isEqualTo: email)
              .get();

      if (userSnapshot.docs.isNotEmpty) {
        final userDoc = userSnapshot.docs[0];
        return userDoc.data();
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
