import 'dart:convert';

import 'package:currency_conversion/utils/constant.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyLiveController extends GetxController{

  var format , amount;


  Future<String> loadCurrenciesLive() async{

    var response = await Dio().get(Constants().apiUrl + Constants().typeLive + Constants().textAccessKey + "=" + Constants().accessKey);
    Map curMap = response.data["quotes"];
    String encodeMap = json.encode(curMap);
    
    final prefs = await SharedPreferences.getInstance();
    DateTime curTime = new DateTime.now();
    prefs.setInt(Constants().timeStand, curTime.millisecondsSinceEpoch);
    prefs.setString(Constants().exchangeRates, encodeMap);

    format = curMap.keys.toList();
    amount = curMap.values.toList();

    update();
    return "Success";

  }

  getExchangeRate() async{
    final prefs = await SharedPreferences.getInstance();
    String? encodedMap = prefs.getString(Constants().exchangeRates);
    Map curMap = json.decode(encodedMap!);
    format = curMap.keys.toList();
    amount = curMap.values.toList();
    update();
    print(format);
  }

}