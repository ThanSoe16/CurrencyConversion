  import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:currency_conversion/utils/constant.dart';
import 'package:currency_conversion/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
  configLoading();
}

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: ConnectivityWidgetWrapper(
        stacked: false,
        disableInteraction: true,
        offlineWidget: MaterialApp(
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Constants().secondaryColor,
                          offset: Offset.infinite,
                          blurRadius: 10
                      )],
                     borderRadius: BorderRadius.circular(20),
                      color: Colors.grey
                    ),
                    child: Icon(
                      Icons.wifi_off,
                      color: Constants().primaryColor,
                      size: 100,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Oops...",
                      style: TextStyle(
                          color: Constants().textTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Constants().textTitleSize)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("No Internet Connection",
                      style: TextStyle(
                          color: Constants().textTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Constants().textTitleSize))
                ],
              ),
            ),
          ),
        ),
        child: const GetMaterialApp(
          home: Home(),
        ),
      ),

    );
  }
}
