import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String name;
  final String companyName;

  const LoginButtonPressed({required this.name, required this.companyName});

  @override
  List<Object> get props => [name, companyName];
}
