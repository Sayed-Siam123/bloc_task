import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiProvider{
  //
  static const _baseUrl = 'https://bd.ezassist.me/ws/mpFeed?instanceName=bd.ezassist.me';
  
  Future<dynamic> fetchFeaturedSeller() async {
    Uri uri = Uri.parse("$_baseUrl&opt=trending_seller");
    Response response = await http.get(uri);
    return jsonDecode(response.body);
  }
}