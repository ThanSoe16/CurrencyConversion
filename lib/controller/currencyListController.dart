import 'dart:convert';

import 'package:currency_conversion/utils/constant.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyListController extends GetxController{

  var items;

  Future<String> loadCurrencies() async{
      var response = await Dio().get(Constants().apiUrl + Constants().typeList + Constants().textAccessKey + "=" + Constants().accessKey);
      Map curMap = response.data["currencies"];
      items = curMap.keys.toList();

      final prefs = await SharedPreferences.getInstance();
      String encodeMap = json.encode(curMap);
      prefs.setString(Constants().currencyLists, encodeMap);

      update();
    return "success";

  }

  Future<String> getCurrencyList() async{
    final prefs = await SharedPreferences.getInstance();
    String? encodedMap = prefs.getString(Constants().currencyLists);
    Map curMap = json.decode(encodedMap!);
    items = curMap.keys.toList();
    update();
    return "success";



  }

}