import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spend_smart/config/routes/app_router.dart';
import 'package:spend_smart/config/routes/routes.dart';
import 'package:spend_smart/core/di/service_locator.dart';
import 'package:spend_smart/core/prefrences/apppref.dart';
import 'package:spend_smart/features/auth/presentation/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'package:spend_smart/features/auth/presentation/bloc/google_signin_bloc/google_signin_bloc.dart';
import 'package:spend_smart/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:spend_smart/features/auth/presentation/bloc/password_visiblity_cubit.dart';
import 'package:spend_smart/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:spend_smart/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:spend_smart/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:spend_smart/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPref.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  serviceLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnboardingCubit>(
          create: (context) => OnboardingCubit(),
        ),
        BlocProvider<PasswordVisiblityCubit>(
          create: (context) => PasswordVisiblityCubit(),
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
      ],
      child: MaterialApp(
        title: 'Spend Smart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: Routes.onboarding,
        onGenerateRoute: AppRouter.generateRoute,
        home: const OnboardingScreen(),
      ),
    );
  }
}
