import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spend_smart/core/error/exception.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/features/auth/domain/auth_usecase.dart';
import 'package:spend_smart/features/auth/domain/user_entity.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc({required this.signUpUseCase}) : super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  Future<void> _onSignUpSubmitted(
      SignUpSubmitted event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    try {
      final user = await signUpUseCase(
        SignUpParams(
          userName: event.userName,
          email: event.email,
          password: event.password,
        ),
      );
      emit(SignUpSuccess(user: user));
    } on AuthExecption catch (e) {
      emit(SignUpFailure(message: e.message));
    } on CustomTimeOutException {
      emit(SignUpFailure(message: AppString.requestTimeout));
    } catch (e) {
      emit(SignUpFailure(message: AppString.unexpectedError));
    }
  }
}
