import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/login_bloc.dart';
import '../../../blocs/login_state.dart';
import '../../viewmodels/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _nameController = TextEditingController();
  final _companyNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginViewModel =
        LoginViewmodel(loginBloc: BlocProvider.of<LoginBloc>(context));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushNamed(context, '/home');
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _companyNameController,
                decoration: const InputDecoration(labelText: 'Company Name'),
              ),
              ElevatedButton(
                onPressed: () {
                  loginViewModel.login(
                    _nameController.text,
                    _companyNameController.text,
                  );
                },
                child: const Text('Login'),
              ),
              // BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              //   return state is LoginLoading
              //       ? const CircularProgressIndicator()
              //       : const SizedBox.shrink();
              // })
            ],
          ),
        ),
      ),
    );
  }
}
