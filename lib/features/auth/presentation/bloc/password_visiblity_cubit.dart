import 'package:bloc/bloc.dart';

class PasswordVisibilityCubit extends Cubit<Map<String, bool>> {
  PasswordVisibilityCubit()
      : super({
          'password': true,
          'confirmPassword': true,
          'loginPassword': true,
        });

  void togglePasswordVisibility() {
    emit({...state, 'password': !state['password']!});
  }

  void toggleConfirmPasswordVisibility() {
    emit({...state, 'confirmPassword': !state['confirmPassword']!});
  }

  void toggleLoginPasswordVisibility() {
    emit({...state, 'loginPassword': !state['loginPassword']!});
  }
}
