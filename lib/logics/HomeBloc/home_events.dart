// enum HomeEvents {
//   fetchFeaturedSeller,
// }


import 'package:flutter/material.dart';

@immutable
abstract class HomeEvents {}

class FetchFeaturedSeller extends HomeEvents {}
class GetData extends HomeEvents {
  final int? id;

  GetData(this.id);
}
