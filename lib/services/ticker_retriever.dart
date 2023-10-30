import 'networking.dart';
//import 'fake_networking.dart';

class TickerRetriever{
  String url = "https://rest.coinapi.io/v1/exchangerate/";
  String key= "D7658879-A7EC-4DA7-92D3-5E886E22241A";

  Future<dynamic> getPrice(String tickerName, String fiatName) async{
    NetworkHelper networkHelper = NetworkHelper(url: "$url$tickerName/$fiatName?apikey=$key");
    return await networkHelper.getData();

    // FakeNetworkHelper fakeNetworkHelper = FakeNetworkHelper(
    //     ticker: tickerName
    // );
    // return await fakeNetworkHelper.getData().timeout(const Duration(seconds: 3));
  }

}
