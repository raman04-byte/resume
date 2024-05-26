import '../../blocs/home_blocs/home_bloc.dart';
import '../../blocs/home_blocs/home_state.dart';

class HomeviewModel {
  final HomeBloc _homeBloc;
  HomeviewModel({required HomeBloc homeBloc}) : _homeBloc = homeBloc;
  HomeBloc get homeBloc => _homeBloc;
  Stream<HomeState> get homeState => _homeBloc.stream;
}
