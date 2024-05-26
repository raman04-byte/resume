import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nested/nested.dart';

import 'blocs/home_blocs/home_bloc.dart';
import 'blocs/login_blocs/login_bloc.dart';
import 'data/repositories/auth_repo.dart';
import 'data/repositories/home_repo.dart';
import 'routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  final HomeRepository homeRepository = HomeRepository();

  @override
  Widget build(BuildContext context) {
    List<SingleChildWidget> listOfProvide = [
      BlocProvider(
        create: (context) => LoginBloc(
          authenticationRepository: authenticationRepository,
        ),
      ),
      BlocProvider(
        create: (context) => HomeBloc(
          homeRepository: homeRepository,
        ),
      )
    ];
    return MultiBlocProvider(
      providers: listOfProvide,
      child: MaterialApp(
        title: 'Resume',
        initialRoute: Routes.login,
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          fontFamily: GoogleFonts.robotoMono().fontFamily,
        ),
      ),
    );
  }
}
