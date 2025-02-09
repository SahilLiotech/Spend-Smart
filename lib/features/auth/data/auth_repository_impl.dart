import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spend_smart/core/error/exception.dart';
import 'package:spend_smart/core/services/firebase_service.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/features/auth/data/auth_error_mapper.dart';
import 'package:spend_smart/features/auth/data/user_model.dart';
import 'package:spend_smart/features/auth/domain/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseService firebaseService;

  AuthRepositoryImpl({required this.firebaseService});
  @override
  Future<UserModel> signUpWithEmailAndPassword(
      String userName, String email, String password) async {
    try {
      final userCredential = await firebaseService.auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException(AppString.requestTimeout);
        },
      );

      final user = UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        name: userName,
        image: '',
      );

      await firebaseService.firestore
          .collection('users')
          .doc(user.id)
          .set(user.toMap());

      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthExecption(AuthErrorMapper.map(e.code));
    } on TimeoutException {
      throw AuthExecption(AppString.requestTimeout);
    } on FirebaseException catch (e) {
      throw AuthExecption(AuthErrorMapper.map(e.code));
    } catch (e) {
      if (firebaseService.auth.currentUser != null) {
        await firebaseService.auth.currentUser!.delete();
      }
      throw AuthExecption(AppString.unexpectedError);
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await firebaseService.auth
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException(AppString.requestTimeout);
        },
      );

      final userDoc = await firebaseService.firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      return UserModel.fromMap(userDoc.data()!);
    } on FirebaseAuthException catch (e) {
      debugPrint("error ::::: ${e.code}");
      throw AuthExecption(AuthErrorMapper.map(e.code));
    } on TimeoutException {
      throw AuthExecption(AppString.requestTimeout);
    } on FirebaseException catch (e) {
      throw AuthExecption(AuthErrorMapper.map(e.code));
    } catch (e) {
      throw AuthExecption(AppString.unexpectedError);
    }
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      final user = firebaseService.auth.currentUser;
      if (user == null) return null;
      final userDoc = await firebaseService.firestore
          .collection('users')
          .doc(user.uid)
          .get()
          .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException(AppString.requestTimeout);
        },
      );
      return UserModel.fromMap(userDoc.data()!);
    } on FirebaseAuthException catch (e) {
      throw AuthExecption(AuthErrorMapper.map(e.code));
    } on TimeoutException {
      throw AuthExecption(AppString.requestTimeout);
    } on FirebaseException catch (e) {
      throw AuthExecption(AuthErrorMapper.map(e.code));
    } catch (e) {
      throw AuthExecption(AppString.unexpectedError);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await firebaseService.auth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e) {
      throw AuthExecption(AuthErrorMapper.map(e.code));
    } catch (e) {
      throw AuthExecption(AppString.unexpectedError);
    }
  }

  @override
  Future<bool> isSignedIn() async {
    return firebaseService.auth.currentUser != null;
  }

  @override
  Future<void> signOut() async {
    await firebaseService.auth.signOut();
  }
}
