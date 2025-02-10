part of 'google_signin_bloc.dart';

sealed class GoogleSigninEvent extends Equatable {
  const GoogleSigninEvent();

  @override
  List<Object> get props => [];
}

class GoogleSigninSubmitted extends GoogleSigninEvent {}
