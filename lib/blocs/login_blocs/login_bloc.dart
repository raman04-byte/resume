import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repo.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginBloc({required this.authenticationRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final user = await authenticationRepository.authenticate(
          event.name, event.companyName);
      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(const LoginFailure('Invalid'));
      }
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }
}
