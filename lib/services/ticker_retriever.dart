import 'networking.dart';
import 'fake_networking.dart';

class TickerRetriever{

  Future getPrice(String tickerName, String fiatName) async{
    return await FakeNetworkHelper().getData();
  }

}
