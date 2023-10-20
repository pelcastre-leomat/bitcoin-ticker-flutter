import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/services/ticker_retriever.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  TickerRetriever tickerRetriever = TickerRetriever();
  Map<String, int> assetPriceList = {};
  String selectedCurrency = currenciesList[0];
  double price = 0;

  @override
  void initState() {
    updateUI("USD");
    super.initState();
  }

  void updateUI(String currency) async{
    for(String asset in cryptoList){

      var responseRate = await tickerRetriever.getPrice(asset, currency);
      assetPriceList[asset] = responseRate["rate"].round();
    }

    setState(() {
      assetPriceList;
      price = 20;
    });
  }
  
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownMenuItems = [];
    for(String currency in currenciesList){
      var newItem = DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
      );
      dropdownMenuItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownMenuItems,
      onChanged: (value){
        setState(() {
          selectedCurrency = value!;
          updateUI(selectedCurrency);
        });
      },
    );
  }

  CupertinoPicker iOSPicker(){
    List<Text> pickerItems = [];
    for(String currency in currenciesList){
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(

      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex){
        selectedCurrency = pickerItems[selectedIndex].data ?? "";
        updateUI(selectedCurrency);
      },
      children:pickerItems,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                for (String asset in cryptoList)
                  AssetCardWidget(
                      price: assetPriceList[asset] ?? 0,
                      selectedCurrency: selectedCurrency,
                      asset: asset,
                )
              ],
            )
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? iOSPicker():androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class AssetCardWidget extends StatelessWidget {
  const AssetCardWidget({
    super.key,
    required this.price,
    required this.selectedCurrency,
    required this.asset,
  });


  final int price;
  final String asset;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 70,
      child: Card(

        color: Colors.lightBlueAccent,
        elevation: 5.0,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $asset = ${price.toInt()} $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}