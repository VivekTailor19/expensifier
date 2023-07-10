import 'package:expensifier/model/intro_model.dart';
import 'package:expensifier/screens/01_home_screen/view/homeScreen.dart';
import 'package:expensifier/screens/02_transaction_screen/view/transaction_screen.dart';
import 'package:expensifier/screens/03_budget_screen/view/budget_screen.dart';
import 'package:expensifier/screens/04_profile_screen/view/profile_screen.dart';
import 'package:expensifier/utils/expensifier_database_sqflite_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensifierController extends GetxController
{

  List<IntroModel> introList = [
    IntroModel(introImg: "assets/images/intro/control.png",introTitle: "Gain total control of your money",introData: "Become your own money manager and make every cent count" ),
    IntroModel(introImg: "assets/images/intro/bill.png",introTitle: "Know where yourmoney goes",introData: "Track your transaction easily,with categories and financial report " ),
    IntroModel(introImg: "assets/images/intro/plan.png",introTitle: "Planning ahead",introData: "Setup your budget for each category so you in control" ),
  ];

  RxInt indexBottomBar = 0.obs;
  List<Widget> screenList = [
    HomeScreen(),
    TransactionScreen(),
    BudgetScreen(),
    ProfileScreen()
  ];

  Rx<Color> expenseScreenBgColor = Color(0xff0077FF).obs;

  RxList itemList = [].obs;
  Future<void> load_ExpensifierDB()
  async {
    itemList.value = await Expensifier_DB_Helper.expense_db.readFromDB();
  }

  RxString selCategoryType = 'Food'.obs;
  List<String> categoryList = ['Food','Subscription','Transportation','Shopping','Salary'];

  RxString selCategoryImgPath = "assets/images/category/bill.png".obs;
  Rx<Color> selCategoryBg = Color(0xffFDD5D7).obs;

  void selCategoryTab(String category) {

    if (category == "Food") {
      selCategoryImgPath.value = "assets/images/category/food.png";
      selCategoryBg.value = Color(0xffFDD5D7);
    }
    else if (category == "Subscription") {
      selCategoryImgPath.value = "assets/images/category/bill.png";
      selCategoryBg.value = Color(0xffEEE5FF);
    }
    else if (category == "Transportation") {
      selCategoryImgPath.value = "assets/images/category/car.png";
      selCategoryBg.value = Color(0xffBDDCFF);
    }
    else if (category == "Shopping") {
      selCategoryImgPath.value = "assets/images/category/shopping.png";
      selCategoryBg.value = Color(0xffFCEED4);
    }
    else {
      selCategoryImgPath.value = "assets/images/category/salary.png";
      selCategoryBg.value = Color(0xffCFFAEA);
    }



  }


  RxString selWalletType = 'PayTM'.obs;
  List<String> walletList = ['PayTM','PayPal','PhonePay','GooglePay','BHIM',];

}