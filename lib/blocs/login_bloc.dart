import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/auth_repo.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;
  LoginBloc({required this.authenticationRepository}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) yield LoginLoading();
    if (event is LoginButtonPressed) {
      try {
        final user = await authenticationRepository.authenticate(
            event.name, event.companyName);
        if (user != null) {
          yield LoginSuccess(user);
        } else {
          yield const LoginFailure('Invalid Name or password');
        }
      } catch (error) {
        yield LoginFailure(error.toString());
      }
    }
  }
}
