import 'package:expensifier/screens/addExpense_screen/addExpense_Screen.dart';
import 'package:expensifier/screens/firstScreen.dart';
import 'package:expensifier/screens/home_screen/view/homeScreen.dart';
import 'package:expensifier/screens/profile_screen/view/profile_screen.dart';
import 'package:expensifier/screens/transaction_screen/view/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    Sizer(
      builder:(context, orientation, deviceType) =>  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/expense",
        routes: {
          "/":(p0) => FirstScreen(),
          "/expense":(p0) => AddExpenseScreen(),
          "/home":(p0) => HomeScreen(),
          "/transaction":(p0) => TransactionScreen(),
          "/profile":(p0) => ProfileScreen()
        },
      ),
    ),
  );
}
