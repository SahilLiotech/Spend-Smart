import 'package:get_it/get_it.dart';
import 'package:spend_smart/features/auth/data/auth_repository_impl.dart';
import 'package:spend_smart/features/auth/domain/auth_repository.dart';
import 'package:spend_smart/features/auth/domain/auth_usecase.dart';
import 'package:spend_smart/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:spend_smart/core/services/firebase_service.dart';

final sl = GetIt.instance; // Service Locator instance

void serviceLocator() {
  sl.registerLazySingleton<FirebaseService>(() => FirebaseService());

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseService: sl()));

  sl.registerLazySingleton(() => SignUpUseCase(repository: sl()));
  sl.registerLazySingleton(() => SignInUseCase(repository: sl()));
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => SendPasswordResetEmailUseCase(repository: sl()));

  sl.registerFactory(() => AuthBloc(
        signUpUseCase: sl(),
        signInUseCase: sl(),
        signOutUseCase: sl(),
        getUserUseCase: sl(),
        sendPasswordResetEmailUseCase: sl(),
      ));
}
