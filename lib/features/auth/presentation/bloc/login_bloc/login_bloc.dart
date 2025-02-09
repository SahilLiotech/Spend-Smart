import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spend_smart/core/error/exception.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/features/auth/domain/auth_usecase.dart';
import 'package:spend_smart/features/auth/domain/user_entity.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignInUseCase signInUseCase;

  LoginBloc({required this.signInUseCase}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final user = await signInUseCase(
        SignInParams(
          email: event.email,
          password: event.password,
        ),
      );
      emit(LoginSuccess(user: user));
    } on AuthExecption catch (e) {
      emit(LoginFailure(message: e.message));
    } on TimeoutException {
      emit(LoginFailure(message: AppString.requestTimeout));
    } catch (e) {
      emit(LoginFailure(message: AppString.unexpectedError));
    }
  }
}
