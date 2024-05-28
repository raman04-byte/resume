import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/login_blocs/login_bloc.dart';
import '../../../blocs/login_blocs/login_state.dart';
import '../../../resources/dimens.dart';
import '../../../routes.dart';
import '../../viewmodels/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _nameController = TextEditingController();
  final _companyNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    context.read<DimensionBloc>().add(
          UpdateDimensions(
            MediaQuery.sizeOf(context).height,
            MediaQuery.sizeOf(context).width,
          ),
        );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel =
        LoginViewmodel(loginBloc: BlocProvider.of<LoginBloc>(context));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.home);
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, Routes.home);
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: BlocBuilder<DimensionBloc, DimensionState>(
          builder: (context, dimensionState) {
            if (dimensionState.screenHeight == 0 ||
                dimensionState.screenWidth == 0) {
              return const Center(child: CircularProgressIndicator());
            }
            final dimensionBloc = context.read<DimensionBloc>();

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dimensionBloc.scaleW(20),
                vertical: dimensionBloc.scaleH(4),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: _companyNameController,
                    decoration:
                        const InputDecoration(labelText: 'Company Name'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      loginViewModel.login(
                        _nameController.text,
                        _companyNameController.text,
                      );
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
