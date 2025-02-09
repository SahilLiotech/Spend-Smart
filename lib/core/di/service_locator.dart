import 'package:get_it/get_it.dart';
import 'package:spend_smart/core/services/firebase_service.dart';
import 'package:spend_smart/features/auth/data/auth_repository_impl.dart';
import 'package:spend_smart/features/auth/domain/auth_repository.dart';
import 'package:spend_smart/features/auth/domain/auth_usecase.dart';
import 'package:spend_smart/features/auth/presentation/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'package:spend_smart/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:spend_smart/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';

final sl = GetIt.instance; // Service Locator instance

void serviceLocator() {
  // Services
  sl.registerLazySingleton<FirebaseService>(() => FirebaseService());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseService: sl()));

  // Use Cases
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(repository: sl()));
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(repository: sl()));
  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(repository: sl()));
  sl.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(repository: sl()));
  sl.registerLazySingleton<SendPasswordResetEmailUseCase>(
      () => SendPasswordResetEmailUseCase(repository: sl()));

  // BLoCs
  sl.registerFactory<SignUpBloc>(() => SignUpBloc(signUpUseCase: sl()));
  sl.registerFactory<LoginBloc>(() => LoginBloc(signInUseCase: sl()));
  sl.registerFactory<ForgetPasswordBloc>(
      () => ForgetPasswordBloc(sendPasswordResetEmailUseCase: sl()));
}
