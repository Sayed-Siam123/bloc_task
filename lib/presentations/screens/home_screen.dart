import 'package:bloc_task/constant/enums/enums.dart';
import 'package:bloc_task/logics/HomeBloc/home_bloc.dart';
import 'package:bloc_task/logics/HomeBloc/home_events.dart';
import 'package:bloc_task/logics/HomeBloc/home_state.dart';
import 'package:bloc_task/logics/InternetConnectivity/internet_connectivity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadAlbums();
  }

  _loadAlbums() async {
    //context.read<HomeBloc>().add(FetchFeaturedSeller());
    context.read<HomeBloc>().add(GetData(1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetConnectivityCubit, InternetConnectivityState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.wifi) {
          context.read<HomeBloc>().add(FetchFeaturedSeller());
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.mobile) {
          context.read<HomeBloc>().add(FetchFeaturedSeller());
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No internet")));
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<HomeBloc, HomePageState>(
                builder: (BuildContext context, HomePageState state) {
                  // if (state is HomePageListError) {
                  //   final error = state.error;
                  //   String message = '${error.message}\nTap to Retry.';
                  //   //return Text(message.toString());
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${error.message}")));
                  // }
                  if (state is HomePageLoaded) {
                    final sellerData = state.sellerData;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: sellerData!.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return const Text("sas");
                        },
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }
}
