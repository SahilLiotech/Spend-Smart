import 'package:get_it/get_it.dart';
import 'package:spend_smart/core/services/firebase_service.dart';
import 'package:spend_smart/features/category/domain/usecases/get_category_usecase.dart';
import 'package:spend_smart/features/transactions/data/repository/transaction_repository_imp.dart';
import 'package:spend_smart/features/transactions/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:spend_smart/features/transactions/presentation/cubit/transaction_type_cubit.dart';
import 'package:spend_smart/features/auth/data/auth_repository_impl.dart';
import 'package:spend_smart/features/auth/domain/auth_repository.dart';
import 'package:spend_smart/features/auth/domain/auth_usecase.dart';
import 'package:spend_smart/features/auth/presentation/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'package:spend_smart/features/auth/presentation/bloc/google_signin_bloc/google_signin_bloc.dart';
import 'package:spend_smart/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:spend_smart/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:spend_smart/features/category/data/category_repository_imp.dart';
import 'package:spend_smart/features/category/domain/repositories/category_repository.dart';
import 'package:spend_smart/features/category/presentation/cubit/category_cubit.dart';
import 'package:spend_smart/features/main/presentation/bloc/navigation_cubit.dart';
import 'package:spend_smart/features/transactions/presentation/cubit/transaction_cubit.dart';

import '../../features/transactions/data/datasources/transaction_remote_datasource.dart';
import '../../features/transactions/data/datasources/transaction_remote_datasource_impl.dart';
import '../../features/transactions/domain/repositories/transaction_repository.dart';
import '../../features/transactions/domain/usecases/add_transaction_usecase.dart';
import '../../features/transactions/domain/usecases/delete_transaction_usecase.dart';
import '../../features/transactions/domain/usecases/get_transactions_usecase.dart';
import '../../features/transactions/domain/usecases/update_transaction_usecase.dart';

final sl = GetIt.instance;

void serviceLocator() {
  // Services
  sl.registerLazySingleton<FirebaseService>(
    () => FirebaseService(),
  );

  // Data Sources

  sl.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(firebaseService: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(firebaseService: sl()),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(),
  );

  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(repository: sl()),
  );
  sl.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(repository: sl()),
  );
  sl.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetUserUseCase>(
    () => GetUserUseCase(repository: sl()),
  );
  sl.registerLazySingleton<SignInWithGoogleUseCase>(
    () => SignInWithGoogleUseCase(repository: sl()),
  );
  sl.registerLazySingleton<SendPasswordResetEmailUseCase>(
    () => SendPasswordResetEmailUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(repository: sl()),
  );
  sl.registerLazySingleton<AddTransactionUseCase>(
    () => AddTransactionUseCase(repository: sl()),
  );
  sl.registerLazySingleton<UpdateTransactionUsecase>(
    () => UpdateTransactionUsecase(repository: sl()),
  );
  sl.registerLazySingleton<DeleteTransactionUseCase>(
    () => DeleteTransactionUseCase(repository: sl()),
  );
  sl.registerLazySingleton<GetTransactionsUseCase>(
    () => GetTransactionsUseCase(repository: sl()),
  );

  // BLoCs
  sl.registerFactory<SignUpBloc>(
    () => SignUpBloc(signUpUseCase: sl()),
  );
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(signInUseCase: sl(), signOutUseCase: sl()),
  );
  sl.registerFactory<ForgetPasswordBloc>(
    () => ForgetPasswordBloc(sendPasswordResetEmailUseCase: sl()),
  );
  sl.registerFactory<GoogleSigninBloc>(
    () => GoogleSigninBloc(signInWithGoogleUseCase: sl()),
  );
  sl.registerFactory<NavigationCubit>(() => NavigationCubit());

  sl.registerFactory<TransactionTypeCubit>(() => TransactionTypeCubit());

  sl.registerFactory<CategoryCubit>(
      () => CategoryCubit(getCategoriesUseCase: sl()));

  sl.registerFactory<TransactionCubit>(() => TransactionCubit());

  sl.registerFactory<TransactionBloc>(() => TransactionBloc(
        getTransactionsUseCase: sl(),
        addTransactionUseCase: sl(),
        updateTransactionUseCase: sl(),
        deleteTransactionUseCase: sl(),
      ));
}
