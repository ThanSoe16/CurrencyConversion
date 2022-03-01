import 'dart:convert';

import 'package:currency_conversion/controller/currencyListController.dart';
import 'package:currency_conversion/controller/currencyLiveController.dart';
import 'package:currency_conversion/utils/constant.dart';
import 'package:currency_conversion/view/converter.dart';
import 'package:currency_conversion/widget/CurrencyFormat.dart';
import 'package:currency_conversion/widget/exchangeRateListWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String dropdownvalue = "";
  TextEditingController amountController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData()async{
    final prefs = await SharedPreferences.getInstance();
    int? dd = prefs.getInt(Constants().timeStand);
    print(dd);
    DateTime curTime = new DateTime.now();
    DateTime thirtyMinAgo = curTime.subtract(Duration(minutes: 30));
    int thirtyMinAgoInMs = thirtyMinAgo.millisecondsSinceEpoch;
    print(thirtyMinAgoInMs);
    if(dd==null){
      print("Empty");
      Get.lazyPut(() => CurrencyLiveController());
      Get.find<CurrencyLiveController>().loadCurrenciesLive();
      Get.lazyPut(() => CurrencyListController());
      Get.find<CurrencyListController>().loadCurrencies();
    }else{
      if(thirtyMinAgoInMs >= dd){
        print("No");
        prefs.clear();
        Get.lazyPut(() => CurrencyLiveController());
        Get.find<CurrencyLiveController>().loadCurrenciesLive();
        Get.lazyPut(() => CurrencyListController());
        Get.find<CurrencyListController>().loadCurrencies();
      }else{
        print("Yes");
        Get.lazyPut(() => CurrencyLiveController());
        Get.find<CurrencyLiveController>().getExchangeRate();
        Get.lazyPut(() => CurrencyListController());
        Get.find<CurrencyListController>().getCurrencyList();
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Currency",
                  style: TextStyle(
                      color: Constants().primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
              Text("Exchange Rates",
                  style: TextStyle(
                      color: Constants().primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
              const SizedBox(height: 35,),

              Text("From",
                  style: TextStyle(
                      color: Constants().textTitleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
              const SizedBox(height: 15,),
              GetBuilder<CurrencyListController>(
                  init: CurrencyListController(),
                  builder: (v) {
                    return Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      color: Constants().secondaryColor,
                      child: DropDown<String>(
                        items: v.items==null? ["USD","MMK"] : v.items,
                        showUnderline: false,
                        hint: Text("Select Currency",
                            style: TextStyle(
                                color: Constants().textNormalColor,
                                fontWeight: FontWeight.normal,
                                fontSize: Constants().textTitleSize)),

                        onChanged: (val){
                          dropdownvalue = val!;
                        },
                      ),
                    );
                  }
              ),

              const SizedBox(height: 35,),

              MaterialButton(
                onPressed: () async{
                  if(dropdownvalue == ""){
                    await EasyLoading.showError(
                        "Currency is Empty", dismissOnTap: true);
                    final prefs = await SharedPreferences.getInstance();

                  }else{
                    Get.to(Converter());
                  }

                },
                color: Constants().primaryColor,
                minWidth:
                MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(10)),
                height: 55,
                child: const Text("Confirm",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
              const SizedBox(height: 20,),
              GetBuilder<CurrencyLiveController>(
                  init: CurrencyLiveController(),
                  builder: (v) {
                    return v.format != null ? ListView.builder(
                        padding: EdgeInsets.only(bottom: 10),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 168,
                        itemBuilder: (context, position) {
                          return ExchangeRateListWidget(
                            from: v.format[position].toString().substring(0, 3),
                            to: v.format[position].toString().substring(3, 6),
                            amount: v.amount[position].toString(),);
                        }): SizedBox();
                  }
              )

            ],
          ),


        ),
      ),
    );
  }
}
