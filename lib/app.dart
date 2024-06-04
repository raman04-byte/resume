import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nested/nested.dart';

import 'blocs/home_blocs/home_bloc.dart';
import 'blocs/login_blocs/login_bloc.dart';
import 'data/repositories/auth_repo.dart';
import 'data/repositories/home_repo.dart';
import 'gen_l10n/app_localizations.dart';
import 'resources/resources.dart' as resources;
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
      ),
      BlocProvider(create: (context) => resources.DimensionBloc()),
    ];
    return MultiBlocProvider(
      providers: listOfProvide,
      child: MaterialApp(
        title: 'Raman Resume',
        initialRoute: Routes.login,
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale('es'),
        supportedLocales: const [
          // For English
          Locale('en'),
          // For Spanish
          Locale('es'),
        ],
        theme: ThemeData(
          fontFamily: GoogleFonts.robotoMono().fontFamily,
        ),
      ),
    );
  }
}
