import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectCurrency = 'INR';
  String price1 = '?';
  String price2 = '?';
  String price3 = '?';

  DropdownButton androidDropDown() {
    List<DropdownMenuItem<String>> currencyList = [];
    for (String currency in currenciesList) {
      currencyList.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }
    return DropdownButton<String>(
      value: selectCurrency,
      items: currencyList,
      onChanged: (value) {
        setState(() {
          selectCurrency = value!;
        });
        updatePrice();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> cupCurrenyList = [];
    for (String currency in currenciesList) {
      cupCurrenyList.add(Text(currency));
    }
    return CupertinoPicker(
      children: cupCurrenyList,
      itemExtent: 32,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectCurrency = currenciesList[selectedIndex];
        });
        updatePrice();
      },
    );
  }

  void updatePrice() async {
    try {
      print('heyyyyyy');
      List p = await CoinData().getCoinData(selectCurrency);
      setState(() {
        price1 = p[0];
        price2 = p[1];
        price3 = p[2];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatePrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Bitrack'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          priceCard(
            price: price1,
            currency: selectCurrency,
            cryp: 'BTC',
          ),
          priceCard(
            price: price2,
            currency: selectCurrency,
            cryp: 'ETH',
          ),
          priceCard(
            price: price3,
            currency: selectCurrency,
            cryp: 'LTC',
          ),
          SizedBox(
            height: 406.7,
          ),
          Container(
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
          ),
        ],
      ),
    );
  }
}

class priceCard extends StatelessWidget {
  priceCard({this.cryp, this.price, this.currency});
  String? cryp;
  String? price;
  String? currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${this.cryp} = $price $currency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
