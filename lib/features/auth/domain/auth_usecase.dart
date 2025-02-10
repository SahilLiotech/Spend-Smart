import 'package:spend_smart/core/usecases/usecase.dart';
import 'package:spend_smart/features/auth/domain/auth_repository.dart';
import 'package:spend_smart/features/auth/domain/user_entity.dart';

class SignInUseCase extends UseCase<UserEntity, SignInParams> {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  @override
  Future<UserEntity> call(SignInParams params) {
    return repository.signInWithEmailAndPassword(params.email, params.password);
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}

class SignUpUseCase extends UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  @override
  Future<UserEntity> call(SignUpParams params) {
    return repository.signUpWithEmailAndPassword(
        params.userName, params.email, params.password);
  }
}

class SignUpParams {
  final String userName;
  final String email;
  final String password;

  SignUpParams(
      {required this.userName, required this.email, required this.password});
}

class SignInWithGoogleUseCase extends NoParams {
  final AuthRepository repository;

  SignInWithGoogleUseCase({required this.repository});

  @override
  Future<UserEntity> call() {
    return repository.signInWithGoogle();
  }
}

class SignOutUseCase extends NoParams {
  final AuthRepository repository;

  SignOutUseCase({required this.repository});

  @override
  Future<void> call() {
    return repository.signOut();
  }
}

class CheckAuthUseCase extends NoParams {
  final AuthRepository repository;

  CheckAuthUseCase({required this.repository});

  @override
  Future<UserEntity?> call() {
    return repository.getUser();
  }
}

class SendPasswordResetEmailUseCase
    extends UseCase<void, SendPasswordResetEmailParams> {
  final AuthRepository repository;

  SendPasswordResetEmailUseCase({required this.repository});

  @override
  Future<void> call(SendPasswordResetEmailParams params) {
    return repository.sendPasswordResetEmail(params.email);
  }
}

class SendPasswordResetEmailParams {
  final String email;

  SendPasswordResetEmailParams({required this.email});
}

class GetUserUseCase extends NoParams {
  final AuthRepository repository;

  GetUserUseCase({required this.repository});

  @override
  Future<UserEntity?> call() {
    return repository.getUser();
  }
}
