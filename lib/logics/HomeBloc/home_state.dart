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
  final List<dynamic>? trendingProducts;
  final List<dynamic>? newArrival;
  final List<dynamic>? newShops;
  final List<dynamic>? productsStories;

  HomePageLoaded(
      {this.trendingProducts,
      this.newArrival,
      this.newShops,
      this.productsStories,
      this.sellerData});
}
class HomePageListError extends HomePageState {
  final error;
  HomePageListError({this.error});
}