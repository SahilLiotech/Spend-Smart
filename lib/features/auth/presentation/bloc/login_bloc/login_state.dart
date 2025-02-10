part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserEntity user;

  const LoginSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class LoginWithGoogleSuccess extends LoginState {
  final UserEntity user;

  const LoginWithGoogleSuccess({required this.user});

  @override
  List<Object> get props => [user];
}
