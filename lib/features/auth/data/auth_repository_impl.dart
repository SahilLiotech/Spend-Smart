import 'package:spend_smart/core/services/firebase_service.dart';
import 'package:spend_smart/features/auth/data/user_model.dart';
import 'package:spend_smart/features/auth/domain/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseService firebaseService;

  AuthRepositoryImpl({required this.firebaseService});
  @override
  Future<UserModel> signUpWithEmailAndPassword(
      String userName, String email, String password) async {
    final userCredential = await firebaseService.auth
        .createUserWithEmailAndPassword(email: email, password: password);
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
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await firebaseService.auth
        .signInWithEmailAndPassword(email: email, password: password);

    final userDoc = await firebaseService.firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .get();
    return UserModel.fromMap(userDoc.data()!);
  }

  @override
  Future<UserModel?> getUser() async {
    final user = firebaseService.auth.currentUser;
    if (user == null) return null;
    final userDoc =
        await firebaseService.firestore.collection('users').doc(user.uid).get();
    return UserModel.fromMap(userDoc.data()!);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await firebaseService.auth.sendPasswordResetEmail(email: email);
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
