import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const aPIKey = '10939B6C-8424-45FE-9925-0F2FA84E1F6C';
const uRL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<List<String>> getCoinData(country) async {
    Response response =
        await http.get(Uri.parse('$uRL/BTC/$country?apikey=$aPIKey'));
    Response response2 =
        await http.get(Uri.parse('$uRL/ETH/$country?apikey=$aPIKey'));
    Response response3 =
        await http.get(Uri.parse('$uRL/LTC/$country?apikey=$aPIKey'));
    if (response.statusCode == 200) {
      return [
        jsonDecode(response.body)["rate"].toStringAsFixed(0),
        jsonDecode(response2.body)["rate"].toStringAsFixed(0),
        jsonDecode(response3.body)["rate"].toStringAsFixed(0)
      ];
      ;
    } else {
      print(['errrrrrrrrrrrrrrrrrrrrrrrr']);
      return ["Error", "Error", "Error"];
    }
  }
}

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
