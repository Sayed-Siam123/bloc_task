import 'dart:io';

import 'package:bloc_task/data/dataprovider/api_provider.dart';
import 'package:bloc_task/logics/HomeBloc/home_events.dart';
import 'package:bloc_task/logics/HomeBloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvents, HomePageState> {

  final ApiProvider apiProvider;

  HomeBloc({required this.apiProvider}) : super(HomePageInitState());
  @override
  Stream<HomePageState> mapEventToState(HomeEvents event) async* {
    if(event is FetchFeaturedSeller){
      yield HomePageLoading();
      try {
        final sellerData = await apiProvider.fetchFeaturedSeller();
        print(sellerData);
        yield HomePageLoaded(sellerData: sellerData[0]);
      } on SocketException {
        yield HomePageListError(
          error: NoInternetException('No Internet'),
        );
      } on HttpException {
        yield HomePageListError(
          error: NoServiceFoundException('No Service Found'),
        );
      } on FormatException {
        yield HomePageListError(
          error: InvalidFormatException('Invalid Response format'),
        );
      } catch (e) {
        yield HomePageListError(
          error: UnknownException('Unknown Error'),
        );
      }
    }
    if(event is GetData){
      print(event.id); // to pass id or pass the data to the bloc using event class
    }
  }
}


class NoInternetException {
  var message;
  NoInternetException(this.message);
}
class NoServiceFoundException {
  var message;
  NoServiceFoundException(this.message);
}
class InvalidFormatException {
  var message;
  InvalidFormatException(this.message);
}
class UnknownException {
  var message;
  UnknownException(this.message);
}