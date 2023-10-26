import 'package:bitcoin_ticker/Components/android_dropdown.dart';
import 'package:bitcoin_ticker/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome,SystemUiMode,DeviceOrientation;

import 'coin_data.dart';

class PriceScreenRedesign extends StatefulWidget {
  const PriceScreenRedesign({Key? key}) : super(key: key);

  @override
  State<PriceScreenRedesign> createState() => _PriceScreenRedesignState();
}

class _PriceScreenRedesignState extends State<PriceScreenRedesign> {
  String selectedCurrency = currenciesList[0];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
              AssetCardWidget(
                color: Colors.pink,
                price: 2,
                fiat: selectedCurrency,
                assetIcon: "icons/ltc.png",
                asset: "LTC",
                width: double.infinity,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AssetCardWidget(
                    asset: "ETH",
                    assetIcon: "icons/eth.png",
                    fiat: selectedCurrency,
                    price: 17272,
                    color: Color(0xffafc0ff),
                  ),
                  AssetCardWidget(
                    asset: "BTC",
                    assetIcon: "icons/btc.png",
                    fiat: selectedCurrency,
                    price: 2020,
                    color: Color(0xffecff78),

                  ),
                ],
              ),
              Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: AndroidDropDown(
                    onChanged: (value){
                      setState(() {
                        selectedCurrency = value;
                      });
                    },
                    currenciesList: currenciesList,
                    selectedCurrency: selectedCurrency,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AssetCardWidget extends StatelessWidget {
  String assetIcon;
  int price;
  String asset;
  String fiat;
  Color color;
  double? width;

  AssetCardWidget({super.key, required this.assetIcon,required this.price,
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
              AssetImage(assetIcon),
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
