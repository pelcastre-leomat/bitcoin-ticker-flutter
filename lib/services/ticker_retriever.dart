import 'networking.dart';
import 'fake_networking.dart';

class TickerRetriever{
  String url = "https://rest.coinapi.io/v1/exchangerate/";
  String key= "x";

  Future<dynamic> getPrice(String tickerName, String fiatName) async{
    //
    // NetworkHelper networkHelper = NetworkHelper(url: "$url$tickerName/$fiatName?apikey=$key");
    // return await networkHelper.getData();
    //
    //


    FakeNetworkHelper fakeNetworkHelper = FakeNetworkHelper(
        ticker: tickerName
    );
    return await fakeNetworkHelper.getData().timeout(Duration(seconds: 3));
  }

}
