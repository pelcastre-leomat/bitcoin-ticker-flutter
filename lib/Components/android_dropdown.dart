import 'package:flutter/material.dart';

class AndroidDropDown extends StatelessWidget {
  final Function onChanged;
  final List<String> currenciesList;

  AndroidDropDown({super.key, required this.onChanged, required this.currenciesList});



  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownMenuItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
      );
      dropdownMenuItems.add(newItem);
    }
    return DropdownButton<String>(
        //value: selectedCurrency,
        items: dropdownMenuItems,
        onChanged: (value){

          //TODO update UI
          onChanged();
        });
    }

  @override
  Widget build(BuildContext context) {
    return androidDropdown()
  }
}

