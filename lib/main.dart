import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:spend_smart/config/routes/app_router.dart';
import 'package:spend_smart/config/routes/routes.dart';
import 'package:spend_smart/core/di/service_locator.dart';
import 'package:spend_smart/core/prefrences/apppref.dart';
import 'package:spend_smart/features/transactions/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:spend_smart/features/transactions/presentation/cubit/transaction_filter_cubit.dart';
import 'package:spend_smart/features/transactions/presentation/cubit/transaction_type_cubit.dart';
import 'package:spend_smart/features/auth/domain/auth_repository.dart';
import 'package:spend_smart/features/auth/presentation/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'package:spend_smart/features/auth/presentation/bloc/google_signin_bloc/google_signin_bloc.dart';
import 'package:spend_smart/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:spend_smart/features/auth/presentation/bloc/password_visiblity_cubit.dart';
import 'package:spend_smart/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:spend_smart/features/category/presentation/cubit/category_cubit.dart';
import 'package:spend_smart/features/main/presentation/bloc/navigation_cubit.dart';
import 'package:spend_smart/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:spend_smart/features/transactions/presentation/cubit/transaction_date_time_cubit.dart';
import 'package:spend_smart/firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await AppPref.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  serviceLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _initialRoute;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _determineInitialRoute();
    FlutterNativeSplash.remove();
  }

  Future<void> _determineInitialRoute() async {
    final bool isOnboardingDone = AppPref.isOnboardingDone();
    final auth = sl<AuthRepository>();
    final bool isSignedIn = await auth.isSignedIn();

    setState(() {
      if (!isOnboardingDone) {
        _initialRoute = Routes.onboarding;
      } else if (isSignedIn) {
        _initialRoute = Routes.mainLayout;
      } else {
        _initialRoute = Routes.login;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_initialRoute == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<OnboardingCubit>(
          create: (context) => OnboardingCubit(),
        ),
        BlocProvider<PasswordVisibilityCubit>(
          create: (context) => PasswordVisibilityCubit(),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => sl<SignUpBloc>(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => sl<LoginBloc>(),
        ),
        BlocProvider<ForgetPasswordBloc>(
          create: (context) => sl<ForgetPasswordBloc>(),
        ),
        BlocProvider<GoogleSigninBloc>(
          create: (context) => sl<GoogleSigninBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<NavigationCubit>(),
        ),
        BlocProvider(create: (context) => sl<TransactionTypeCubit>()),
        BlocProvider(create: (context) => sl<CategoryCubit>()),
        BlocProvider(create: (context) => sl<TransactionDateTimeCubit>()),
        BlocProvider(create: (context) => sl<TransactionBloc>()),
        BlocProvider(create: (context) => sl<TransactionFilterCubit>()),
      ],
      child: MaterialApp(
        title: 'Spend Smart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: _initialRoute,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
