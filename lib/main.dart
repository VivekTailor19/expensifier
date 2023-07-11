import 'package:device_preview/device_preview.dart';
import 'package:expensifier/screens/01_home_screen/view/homeScreen.dart';
import 'package:expensifier/screens/02_transaction_screen/view/transaction_screen.dart';
import 'package:expensifier/screens/03_budget_screen/view/budget_screen.dart';
import 'package:expensifier/screens/04_profile_screen/view/profile_screen.dart';
import 'package:expensifier/screens/addExpense_screen/addExpense_Screen.dart';
import 'package:expensifier/screens/firstScreen.dart';
import 'package:expensifier/screens/intro_screens/splash_screen.dart';
import 'package:expensifier/screens/updateExpense_screen/updateExpense_Screen.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) =>
    Sizer(
      builder:(context, orientation, deviceType) =>  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'OpenSans'),
         //initialRoute: "/update",
        routes: {
          "/":(p0) => UpdateExpense_DATA(),
          // "/":(p0) => SplashScreen(),
          "/first":(p0) => FirstScreen(),
          "/expense":(p0) => AddExpenseScreen(),
          "/update":(p0) => UpdateExpense_DATA(),
          "/home":(p0) => HomeScreen(),
          "/transaction":(p0) => TransactionScreen(),
          "/budget":(p0) => BudgetScreen(),
          "/profile":(p0) => ProfileScreen()
        },
      ),
    ),
      // ),
  );
}
