import 'package:flutix_app/bloc/movie_bloc.dart';
import 'package:flutix_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'bloc/blocs.dart';
import 'bloc/user_bloc.dart';
import 'ui/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => PageBloc(),
          ),
          BlocProvider(
            create: (_) => UserBloc(),
          ),
          BlocProvider(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider(create: (_) => MovieBloc()..add(FetchMovie())),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) => MaterialApp(
            themeMode: ThemeMode.system,
            theme: themeState.themeData,
            // ThemeData(
            //   brightness: Brightness.light,
            //   accentColor: mainColor,
            // ),
            // darkTheme: ThemeData(
            //     accentColor: Colors.amber[700], brightness: Brightness.dark),
            debugShowCheckedModeBanner: false,
            home: Wrapper(),
          ),
        ),
      ),
    );
  }
}
