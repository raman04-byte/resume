import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/home_blocs/home_bloc.dart';
import '../../../blocs/home_blocs/home_state.dart';
import '../../viewmodels/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final homeViewModel = HomeviewModel(
      homeBloc: BlocProvider.of<HomeBloc>(context),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {},
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text('Home'),
          ),
        ),
      ),
    );
  }
}
