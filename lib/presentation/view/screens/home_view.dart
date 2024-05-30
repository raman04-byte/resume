import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/home_blocs/home_bloc.dart';
import '../../../blocs/home_blocs/home_state.dart';
import '../../viewmodels/home_view_model.dart';
import '../widgets/common/bubble_snackbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void _showCustomSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      duration: Duration(seconds: 5),
      content: BubbleSnackbar(
        message: 'Logged In Successfully',
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _showCustomSnackbar(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = HomeviewModel(
      homeBloc: BlocProvider.of<HomeBloc>(context),
    );
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Home'),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {},
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Center(child: Text('Welcome to the Home Page!')),
        ),
      ),
    );
  }
}
