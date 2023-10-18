import 'dart:convert';
import 'package:bitcoin_ticker/services/networking.dart';
import 'package:http/http.dart' as http;


class FakeNetworkHelper implements NetworkHelper{
  @override
  String url = "http://192.168.0.35:3000/data";

  @override
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    return data;
  }
}