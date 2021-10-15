import 'package:equatable/equatable.dart';

class HomePageState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class HomePageInitState extends HomePageState {}
class HomePageLoading extends HomePageState {}
class HomePageLoaded extends HomePageState {
  final List<dynamic>? sellerData;
  HomePageLoaded({this.sellerData});
}
class HomePageListError extends HomePageState {
  final error;
  HomePageListError({this.error});
}