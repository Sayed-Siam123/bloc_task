import 'package:bloc_task/data/dataprovider/api_provider.dart';
import 'package:bloc_task/logics/HomeBloc/home_bloc.dart';
import 'package:bloc_task/presentations/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Utils/Router/router.dart';

void main() {
  runApp(MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: appRouter.onGeneratedRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: BlocProvider(
      //   create: (context) => HomeBloc(apiProvider: ApiProvider()),
      //   child: const HomeScreen(),
      // ),
    );
  }
}