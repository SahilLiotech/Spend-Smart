import 'package:spend_smart/features/auth/domain/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signInWithEmailAndPassword(String email, String password);
  Future<UserEntity> signUpWithEmailAndPassword(
      String userName, String email, String password);
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<UserEntity?> getUser();
  Future<void> sendPasswordResetEmail(String email);
}
