import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/login_blocs/login_bloc.dart';
import '../../../blocs/login_blocs/login_state.dart';
import '../../../gen_l10n/app_localizations.dart';
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
    final dynamicText= AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(dynamicText?.login ?? 'Login'),
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
                          dynamicText?.typeWritedAnimationText1 ?? 'TypeWrited Animation',
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TypewriterAnimatedText(
                          dynamicText?.typeWritedAnimationText2 ?? 'TypeWrited Animation',
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TypewriterAnimatedText(
                          dynamicText?.typeWritedAnimationText3 ?? 'TypeWrited Animation',
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TypewriterAnimatedText(
                            dynamicText?.typeWritedAnimationText4 ?? 'TypeWrited Animation',
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration:
                        InputDecoration(labelText: dynamicText?.name ?? 'Name'),
                  ),
                  TextField(
                    controller: _companyNameController,
                    decoration: InputDecoration(
                        labelText: dynamicText?.companyName ?? 'Company Name'),
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
                      dynamicText?.login ?? 'Login',
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
