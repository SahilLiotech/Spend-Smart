import 'package:bloc/bloc.dart';


class PasswordVisiblityCubit extends Cubit<bool> {
  PasswordVisiblityCubit() : super(true);

  void toggleVisibility() {
    emit(!state);
  }
}
