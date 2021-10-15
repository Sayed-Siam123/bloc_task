import 'package:bloc_task/data/dataprovider/api_provider.dart';
import 'package:bloc_task/logics/HomeBloc/home_bloc.dart';
import 'package:bloc_task/presentations/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {

  final HomeBloc _homeBloc = HomeBloc(apiProvider: ApiProvider());

  Route? onGeneratedRoute(RouteSettings? route) {
    switch (route!.name) {
      case '/':
        return MaterialPageRoute(
              builder: (_) => BlocProvider(
              create: (context) =>  _homeBloc,
              child: const HomeScreen()
            ),
        );
      default:
        return null;
    }
  }
}