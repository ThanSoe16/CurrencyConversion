import 'dart:convert';

import 'package:currency_conversion/utils/constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConvertCurrencyController extends GetxController{

  double result = 0;

  void convertCurrency(String keys, double amount) async{
    final prefs = await SharedPreferences.getInstance();
    String? encodedMap = prefs.getString(Constants().exchangeRates);
    Map curMap = json.decode(encodedMap!);
    if(curMap.containsKey("USD"+keys)){
      result = amount * curMap["USD"+keys];

    }
    update();
    print(result);


}
}