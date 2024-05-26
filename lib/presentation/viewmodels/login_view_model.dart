import '../../blocs/login_blocs/login_bloc.dart';
import '../../blocs/login_blocs/login_event.dart';
import '../../blocs/login_blocs/login_state.dart';

class LoginViewmodel {
  final LoginBloc _loginBloc;
  LoginViewmodel({required LoginBloc loginBloc}) : _loginBloc = loginBloc;
  LoginBloc get loginBloc => _loginBloc;
  void login(String name, String companyName) {
    _loginBloc.add(LoginButtonPressed(name: name, companyName: companyName));
  }

  Stream<LoginState> get loginState => _loginBloc.stream;
}
