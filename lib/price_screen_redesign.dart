import 'package:bitcoin_ticker/Components/android_dropdown.dart';
import 'package:bitcoin_ticker/price_screen.dart';
import 'package:bitcoin_ticker/services/ticker_retriever.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome,SystemUiMode,DeviceOrientation;

import 'coin_data.dart';
import 'constants.dart';

class PriceScreenRedesign extends StatefulWidget {
  const PriceScreenRedesign({Key? key}) : super(key: key);

  @override
  State<PriceScreenRedesign> createState() => _PriceScreenRedesignState();
}

class _PriceScreenRedesignState extends State<PriceScreenRedesign> {
  String selectedCurrency = currenciesList[0];
  TickerRetriever tickerRetriever = TickerRetriever();
  Map<String, int> assetPriceList = {};
  String biggestCrypto = cryptoList[0];


  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    updateUI();
  }

  void sortMAP(){
    List<MapEntry<String,int>> listMappedEntries = assetPriceList.entries.toList();
    // print(assetPriceList);
    listMappedEntries.sort((b,a)=> a.value.compareTo(b.value));
    assetPriceList = Map.fromEntries(listMappedEntries);
    // print(assetPriceList);
  }

  void updateUI() async{
    for(String asset in cryptoMap.keys){
      var responseRate = await tickerRetriever.getPrice(asset, selectedCurrency);

      setState(() {
        assetPriceList[asset] = responseRate["rate"].round();
      });
    }
    sortMAP();
    biggestCrypto = assetPriceList.keys.first;
    print(biggestCrypto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Crypto Tracker",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: AndroidDropDown(
                        onChanged: (value){
                          setState(() {
                            selectedCurrency = value;
                            updateUI();
                          });
                        },
                        currenciesList: currenciesList,
                        selectedCurrency: selectedCurrency,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              //TODO Move entire column down to bottom half of screen?
              Column(
                children: [
                  AssetCardWidget(width: double.infinity,price: assetPriceList[biggestCrypto], fiat: selectedCurrency, asset: biggestCrypto, color: cryptoMap[biggestCrypto]),
                  SizedBox(
                    height: 10,
                  ),

                  //TODO Break it up for arbitrary-ish number of tiles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for(String asset in assetPriceList.keys.skip(1))
                        AssetCardWidget(price: assetPriceList[asset], fiat: selectedCurrency, asset: asset, color: cryptoMap[asset],)
                    ],
                  ),
                ],
              ),

              //TODO Make a proper button
              TextButton(
                onPressed: (){
                  updateUI();
                },
                child: Text("Reload"))
            ],
          ),
        ),
      ),
    );
  }
}

class AssetCardWidget extends StatelessWidget {
  int? price;
  String asset;
  String fiat;
  Color? color;
  double? width;

  AssetCardWidget({super.key, required this.price,
    required this.asset, required this.fiat, required this.color, this.width});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 165,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20
        ),
        child: Column(
          children: [
            ImageIcon(
              AssetImage("icons/${asset.toLowerCase()}.png"),
              size: 60,
              color: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "$asset/$fiat",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "$price",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// AssetCardWidget(
// color: Colors.pink,
// price: 2,
// fiat: selectedCurrency,
// asset: "LTC",
// width: double.infinity,
// ),
