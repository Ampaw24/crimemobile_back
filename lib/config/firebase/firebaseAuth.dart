import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'firebaseProfile.dart';

String? firebaseUserId;
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

abstract class BaseAuth {
  Future<String> signIn({@required String email});

  Future<String> signUp({@required String email});

  Future<User> getCurrentUser();

  Future<void> sendVerification();

  Future<bool> isEmailVerified();

  Future<void> signOut();

  Future<void> resetPassword(String email);
}

class FireAuth implements BaseAuth {
  final FireProfile _firebaseProfile = FireProfile();

  @override
  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser!;
    return user;
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<String> signUp({
    @required String? email,
    @required String? password,
    @required String? name,
    @required String? studentId,
  }) async {
    try {
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      _firebaseProfile.createAccount(
        firebaseUserId: result.user!.uid,
        email: result.user!.email,
        name: name,
        userId: studentId,
      );
      return "success";
    } on PlatformException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return error.message!;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }
  }

  @override
  Future<String> signIn({
    @required String? email,
    @required String? password,
  }) async {
    signOut();
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      User user = result.user!;
      if (kDebugMode) {
        print("fire out ${user.uid}");
      }
      firebaseUserId = user.uid;
      return "success";
    } on FirebaseAuthException catch (error) {
      if (kDebugMode) {
        print(error.message);
      }
      return error.message!;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }
  }

  @override
  Future<bool> isEmailVerified() async {
    User user = _firebaseAuth.currentUser!;
    return user.emailVerified;
  }

  @override
  Future<void> sendVerification() async {
    User user = _firebaseAuth.currentUser!;
    return user.sendEmailVerification();
  }

  @override
  // ignore: override_on_non_overriding_member
  Future getCurrentUserId() async {
    User user = _firebaseAuth.currentUser!;
    return user.uid;
  }

  @override
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
