import 'package:flutter/material.dart';

class AndroidDropDown extends StatelessWidget {
  final Function onChanged;
  final List<String> currenciesList;
  final String selectedCurrency;

  AndroidDropDown({super.key, required this.onChanged, required this.currenciesList, required this.selectedCurrency});



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
      value: selectedCurrency,
      menuMaxHeight: 300,

      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(20),
      style: const TextStyle(
        color: Colors.black,
      ),
      items: dropdownMenuItems,
      onChanged: (value){
        onChanged(value);
      });
    }

  @override
  Widget build(BuildContext context) {
    return androidDropdown();
  }
}

