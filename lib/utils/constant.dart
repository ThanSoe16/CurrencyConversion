
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:intl/intl.dart';


class Constants{
  Color primaryColor = HexColor("#FFBF00");
  Color secondaryColor = HexColor("#dcdcdc").withOpacity(0.3);
  Color textTitleColor = Colors.black;
  Color textNormalColor = Colors.black12;

  double textTitleSize = 18;
  double textNormalSize = 14;

  final NumberFormat moneyFormat = new NumberFormat("#,###", "en_US");

  String apiUrl = "http://api.currencylayer.com/";
  String accessKey = "5dab9be8ed904a59e67f12c407fa6740";
  String textAccessKey = "?access_key";
  String typeList = "list";
  String typeLive = "live";

  String exchangeRates = "ExchangeRates";
  String currencyLists = "CurrencyLists";
  String timeStand = "TimeStand";

}