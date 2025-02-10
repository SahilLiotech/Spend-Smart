part of 'google_signin_bloc.dart';

sealed class GoogleSigninState extends Equatable {
  const GoogleSigninState();

  @override
  List<Object> get props => [];
}

final class GoogleSigninInitial extends GoogleSigninState {}

final class GoogleSigninLoading extends GoogleSigninState {}

final class GoogleSigninSuccess extends GoogleSigninState {
  final UserEntity user;

  const GoogleSigninSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

final class GoogleSigninFailure extends GoogleSigninState {
  final String message;

  const GoogleSigninFailure({required this.message});

  @override
  List<Object> get props => [message];
}
