part of 'forget_password_bloc.dart';


sealed class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgetPasswordSubmitted extends ForgetPasswordEvent {
  final String email;

  const ForgetPasswordSubmitted({required this.email});

  @override
  List<Object> get props => [email];
}
