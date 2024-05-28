import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/login_blocs/login_bloc.dart';
import '../../../blocs/login_blocs/login_state.dart';
import '../../../resources/resources.dart' as resources;
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
    context.read<resources.DimensionBloc>().add(
          resources.UpdateDimensions(
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
        child: BlocBuilder<resources.DimensionBloc, resources.DimensionState>(
          builder: (context, dimensionState) {
            if (dimensionState.screenHeight == 0 ||
                dimensionState.screenWidth == 0) {
              return const Center(child: CircularProgressIndicator());
            }
            final dimensionBloc = context.read<resources.DimensionBloc>();

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dimensionBloc.scaleW(20),
                vertical: dimensionBloc.scaleH(4),
              ),
              child: Column(
                children: [
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 40.0,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      pause: const Duration(milliseconds: 1000),
                      animatedTexts: [
                        TypewriterAnimatedText(
                            resources.AppStrings().typeWritedAnimationText1),
                        TypewriterAnimatedText(
                            resources.AppStrings().typeWritedAnimationText2),
                        TypewriterAnimatedText(
                            resources.AppStrings().typeWritedAnimationText3),
                        TypewriterAnimatedText(
                            resources.AppStrings().typeWritedAnimationText4),
                      ],
                    ),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration:
                        InputDecoration(labelText: resources.AppStrings().name),
                  ),
                  TextField(
                    controller: _companyNameController,
                    decoration: InputDecoration(
                        labelText: resources.AppStrings().companyName),
                  ),
                  SizedBox(
                    height: dimensionBloc.scaleH(20),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      loginViewModel.login(
                        _nameController.text,
                        _companyNameController.text,
                      );
                    },
                    child: Text(
                      resources.AppStrings().login,
                    ),
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
