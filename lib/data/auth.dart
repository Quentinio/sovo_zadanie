import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../modules/auth/models/user.dart';

class AuthData {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userRef =
  FirebaseFirestore.instance.collection('users');


  Stream<AppUser> disableListener(String uid) {
    return _userRef
        .doc(uid)
        .snapshots()
        .map((event) => AppUser.fromJson(event.data() as Map<String, dynamic>));
  }

  Future<AppUser?> getCurrentUser() async {
    try {
      final firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        final userDoc = await _userRef.doc(firebaseUser.uid).get();
        return AppUser.fromJson(userDoc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }



  Future<AppUser?> signIn(
      {required String email, required String password}) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (authResult.user == null) {
        return null;
      } else {
        final userDoc = await _userRef.doc(authResult.user!.uid).get();
        return AppUser.fromJson(userDoc.data() as Map<String, dynamic>);
      }
    } on FirebaseException catch (e) {
      print(e.message);
    }
    return null;
  }


  Future<AppUser?> resetPassword(
      {required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return null;
    }
    return null;
  }



  Future<AppUser?> signUp(
      {required AppUser appUser, required String password}) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: appUser.email,
        password: password,
      );

      if (authResult.user == null) {
        return null;
      } else {
        appUser.uid = authResult.user!.uid;
        await _userRef.doc(authResult.user!.uid).set(appUser.toJson());
        return appUser;
      }
    } catch (e) {
      return null;
    }
  }


  // Future<void> reset(
  // {required AppUser appUser, required String email}) async {
  //   try {
  //    final authReset = await _auth.sendPasswordResetEmail(
  //        email: appUser.email);
  //   } catch (e) {
  //     return null;
  //   }
  // }





  Future<void> logout() async {
    try {
      await _auth.signOut();
      print('Signed out');
    } catch (e) {
      //
    }
  }
}
