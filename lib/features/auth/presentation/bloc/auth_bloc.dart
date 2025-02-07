import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spend_smart/features/auth/domain/auth_usecase.dart';
import 'package:spend_smart/features/auth/domain/user_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetUserUseCase getUserUseCase;
  final SendPasswordResetEmailUseCase sendPasswordResetEmailUseCase;

  AuthBloc({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.getUserUseCase,
    required this.sendPasswordResetEmailUseCase,
  }) : super(AuthInitial()) {
    on<SignInEvent>(_signInEvent);
    on<SignUp>(_signUpEvent);
    on<SignOutEvent>(_signOutEvent);
    on<CheckAuthEvent>(_checkAuthEvent);
    on<SendPasswordResetEmail>(_resetPasswordEvent);
  }

  _signInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await signInUseCase(
            SignInParams(email: event.email, password: event.password))
        .then((value) => emit(Authenticated(user: value)))
        .catchError((error) => emit(AuthError(message: error.toString())));
  }

  _signUpEvent(SignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await signUpUseCase(SignUpParams(
            userName: event.userName,
            email: event.email,
            password: event.password))
        .then((value) => emit(Authenticated(user: value)))
        .catchError((error) => emit(AuthError(message: error.toString())));
  }

  _signOutEvent(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await signOutUseCase()
        .then((value) => emit(Unauthenticated()))
        .catchError((error) => emit(AuthError(message: error.toString())));
  }

  _checkAuthEvent(CheckAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await getUserUseCase()
        .then((value) => emit(Authenticated(user: value!)))
        .catchError((error) => emit(Unauthenticated()));
  }

  _resetPasswordEvent(
      SendPasswordResetEmail event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await sendPasswordResetEmailUseCase(
            SendPasswordResetEmailParams(email: event.email))
        .then((value) => emit(PasswordResetEmailSent()))
        .catchError((error) => emit(AuthError(message: error.toString())));
  }
}
