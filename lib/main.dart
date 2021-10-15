import 'package:bloc_task/data/dataprovider/api_provider.dart';
import 'package:bloc_task/logics/HomeBloc/home_bloc.dart';
import 'package:bloc_task/presentations/screens/home_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Utils/Router/router.dart';
import 'logics/InternetConnectivity/internet_connectivity_cubit.dart';

void main() {
  runApp(MyApp(appRouter: AppRouter(),connectivity: Connectivity(),));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({Key? key, required this.appRouter,required this.connectivity,}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetConnectivityCubit>(
          create: (context) => InternetConnectivityCubit(connectivity: connectivity),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(apiProvider: ApiProvider()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: appRouter.onGeneratedRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: BlocProvider(
        //   create: (context) => HomeBloc(apiProvider: ApiProvider()),
        //   child: const HomeScreen(),
        // ),
      ),
    );
  }
}