part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignUp extends AuthEvent {
  final String userName;
  final String email;
  final String password;

  const SignUp({
    required this.userName,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [userName, email, password];
}

class SendPasswordResetEmail extends AuthEvent {
  final String email;

  const SendPasswordResetEmail({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class SignOutEvent extends AuthEvent {}

class CheckAuthEvent extends AuthEvent {}
