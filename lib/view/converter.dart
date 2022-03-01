import 'package:currency_conversion/controller/convertCurrencyController.dart';
import 'package:currency_conversion/controller/currencyListController.dart';
import 'package:currency_conversion/utils/constant.dart';
import 'package:currency_conversion/widget/CurrencyFormat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:get/get.dart';

class Converter extends StatefulWidget {
  const Converter({Key? key}) : super(key: key);

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  String? fromvalue,tovalue;
  TextEditingController amountController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.lazyPut(() => CurrencyListController());
    Get.find<CurrencyListController>().getCurrencyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            Text("Converter",
                style: TextStyle(
                    color: Constants().primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
            const SizedBox(
              height: 35,
            ),

            Text("From",
                style: TextStyle(
                    color: Constants().textTitleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
            const SizedBox(
              height: 15,
            ),
            GetBuilder<CurrencyListController>(
                init: CurrencyListController(),
                builder: (v) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    color: Constants().secondaryColor,
                    child: DropDown<String>(
                      items: v.items,
                      initialValue: "USD",
                      showUnderline: false,
                      hint: Text("Select Currency",
                          style: TextStyle(
                              color: Constants().textNormalColor,
                              fontWeight: FontWeight.normal,
                              fontSize: Constants().textTitleSize)),
                      onChanged: (val){
                        fromvalue = val;
                      },
                    ),
                  );
                }),

            const SizedBox(
              height: 35,
            ),
            Text("To",
                style: TextStyle(
                    color: Constants().textTitleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25)),
            const SizedBox(
              height: 15,
            ),
            GetBuilder<CurrencyListController>(
                init: CurrencyListController(),
                builder: (v) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    color: Constants().secondaryColor,
                    child: DropDown<String>(
                      items: v.items,
                      showUnderline: false,
                      hint: Text("Select Currency",
                          style: TextStyle(
                              color: Constants().textNormalColor,
                              fontWeight: FontWeight.normal,
                              fontSize: Constants().textTitleSize)),
                      onChanged: (val){
                        setState(() {
                          tovalue = val!;
                        });
                      },
                    ),
                  );
                }),

            const SizedBox(
              height: 35,
            ),

            ///+++++Amount+++++
            Text("Amount",
                style: TextStyle(
                    color: Constants().textTitleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            const SizedBox(
              height: 15,
            ),

            Center(
              child: Container(
                padding: EdgeInsets.only(left: 15, top: 15),
                height: 55,
                child: TextFormField(
                  controller: amountController,
                  textAlignVertical: TextAlignVertical.center,
                  maxLength: 10,
                  decoration: InputDecoration(
                      counter: SizedBox.shrink(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Enter Amount",
                      hintStyle: TextStyle(
                          color: Constants().textTitleColor,
                          fontWeight: FontWeight.normal,
                          fontSize: Constants().textTitleSize),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 1)),
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.bodyText1!.merge(TextStyle(
                        color: Constants().textTitleColor,
                      )),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter()
                  ],
                ),
                decoration: BoxDecoration(
                  color: Constants().secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            MaterialButton(
              onPressed: () {

                Get.find<ConvertCurrencyController>().convertCurrency(tovalue!, double.parse(amountController.text.toString().replaceAll(',', '')));
              },
              color: Constants().primaryColor,
              minWidth: MediaQuery.of(context).size.width * 0.9,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 55,
              child: Text("Convert",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Result",
                    style: TextStyle(
                        color: Constants().textTitleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
    GetBuilder<ConvertCurrencyController>(
    init: ConvertCurrencyController(),
    builder: (v) {
      return Text( Constants().moneyFormat.format(double.parse(v.result.toString())),

          style: TextStyle(
              color: Constants().textTitleColor,
              fontWeight: FontWeight.bold,
              fontSize: 20));
    }
    ),

              ],
            ),
            const SizedBox(
              height: 15,
            ),

          ],
        ),
      ),
    );
  }
}
