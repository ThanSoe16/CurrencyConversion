
import 'package:currency_conversion/utils/constant.dart';
import 'package:flutter/material.dart';

class ExchangeRateListWidget extends StatelessWidget {

  final String from;
  final String to;
  final String amount;
  const ExchangeRateListWidget({required this.from, required this.to, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.grey[20],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(10,20,10,20),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text("1 " + from,
                    style: TextStyle(
                        color: Constants().textTitleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
              Expanded(flex: 1,child: Icon(Icons.double_arrow,size: 30, color: Constants().primaryColor,)),
              Expanded(
                flex: 5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(amount,
                        style: TextStyle(
                            color: Constants().textTitleColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    Text(to,
                        style: TextStyle(
                            color: Constants().textTitleColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
