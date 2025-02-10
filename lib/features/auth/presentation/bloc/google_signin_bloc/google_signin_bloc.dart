import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spend_smart/core/error/exception.dart';
import 'package:spend_smart/core/utils/string.dart';
import 'package:spend_smart/features/auth/domain/auth_usecase.dart';
import 'package:spend_smart/features/auth/domain/user_entity.dart';

part 'google_signin_event.dart';
part 'google_signin_state.dart';

class GoogleSigninBloc extends Bloc<GoogleSigninEvent, GoogleSigninState> {
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  GoogleSigninBloc({required this.signInWithGoogleUseCase})
      : super(GoogleSigninInitial()) {
    on<GoogleSigninEvent>(_onLoginWithGoogleSubmitted);
  }

  Future<void> _onLoginWithGoogleSubmitted(
      GoogleSigninEvent event, Emitter<GoogleSigninState> emit) async {
    emit((GoogleSigninLoading()));
    try {
      final user = await signInWithGoogleUseCase();
      emit(GoogleSigninSuccess(user: user));
    } on AuthExecption catch (e) {
      emit(GoogleSigninFailure(message: e.message));
    } on TimeoutException {
      emit(GoogleSigninFailure(message: AppString.requestTimeout));
    } catch (e) {
      emit(GoogleSigninFailure(message: AppString.unexpectedError));
    }
  }
}
