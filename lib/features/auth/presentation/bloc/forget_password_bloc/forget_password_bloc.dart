import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spend_smart/core/error/exception.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/features/auth/domain/auth_usecase.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final SendPasswordResetEmailUseCase sendPasswordResetEmailUseCase;

  ForgetPasswordBloc({required this.sendPasswordResetEmailUseCase})
      : super(ForgetPasswordInitial()) {
    on<ForgetPasswordSubmitted>(_onForgetPasswordSubmitted);
  }

  Future<void> _onForgetPasswordSubmitted(
      ForgetPasswordSubmitted event, Emitter<ForgetPasswordState> emit) async {
    emit(ForgetPasswordLoading());
    try {
      await sendPasswordResetEmailUseCase(
        SendPasswordResetEmailParams(email: event.email),
      );
      emit(ForgetPasswordSuccess());
    } on AuthExecption catch (e) {
      emit(ForgetPasswordFailure(message: e.message));
    } on CustomTimeOutException {
      emit(ForgetPasswordFailure(message: AppString.requestTimeout));
    } catch (e) {
      emit(ForgetPasswordFailure(message: AppString.unexpectedError));
    }
  }
}
