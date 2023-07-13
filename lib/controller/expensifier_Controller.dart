import 'package:expensifier/model/intro_model.dart';
import 'package:expensifier/screens/01_home_screen/view/homeScreen.dart';
import 'package:expensifier/screens/02_transaction_screen/view/transaction_screen.dart';
import 'package:expensifier/screens/03_budget_screen/view/budget_screen.dart';
import 'package:expensifier/screens/04_profile_screen/view/profile_screen.dart';
import 'package:expensifier/utils/expensifier_database_sqflite_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class ExpensifierController extends GetxController {

  List<IntroModel> introList = [
    IntroModel(introImg: "assets/images/intro/control.png",
        introTitle: "Gain total control of your money",
        introData: "Become your own money manager and make every cent count"),
    IntroModel(introImg: "assets/images/intro/bill.png",
        introTitle: "Know where yourmoney goes",
        introData: "Track your transaction easily,with categories and financial report "),
    IntroModel(introImg: "assets/images/intro/plan.png",
        introTitle: "Planning ahead",
        introData: "Setup your budget for each category so you in control"),
  ];

  RxInt indexBottomBar = 0.obs;
  List<Widget> screenList = [
    HomeScreen(),
    TransactionScreen(),
    BudgetScreen(),
    ProfileScreen()
  ];

  RxList<Map> additionIncome = <Map>[].obs;
  RxList<Map> additionExpense = <Map>[].obs;

  RxString totalIncome = "".obs;
  RxString totalExpense = "".obs;

  Future<void> loadTotalFind()
  async {
    additionIncome.value = await Expensifier_DB_Helper.expense_db.readMatheMatics('Income');
    additionExpense.value = await Expensifier_DB_Helper.expense_db.readMatheMatics('Expense');
    print("${additionIncome.value}");

    totalIncome.value =   additionIncome.join("");
    totalExpense.value =  additionExpense.join("");
  }


  RxString titleAddScreen = "Income".obs;

  Rx<Color> expenseScreenBgColor = Color(0xff0077FF).obs;

  RxString selTransferFrom = "BHIM".obs;
  RxString selTransferTo = "PhonePay".obs;

  RxString statusInUpdateScreen = "Income".obs;

  RxList itemList = [].obs;


  Future<void> load_ExpensifierDB() async {


    itemList.value = await Expensifier_DB_Helper.expense_db.readFromDB();
    filterList.value = await Expensifier_DB_Helper.expense_db.readFromDB();
  }

  List<String> statusList = [ "Income", "Expense", "Transfer"];
  RxString selStatusType = "Income".obs;

  RxString selCategoryType = 'Food'.obs;
  List<String> categoryList = [
    'Food',
    'Subscription',
    'Transportation',
    'Shopping',
    'Salary'
  ];

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
  List<String> walletList = [
    'PayTM',
    'PayPal',
    'PhonePay',
    'GooglePay',
    'BHIM',
  ];

  //   Date

  RxString selDate = "${DateTime.now()}".obs;

  String setDateFormat(DateTime dt) {
    var f = DateFormat("dd-MM-yyyy");
    return f.format(dt);
  }

  RxString selTime = "${TimeOfDay.now()}".obs;


  // FilterDatas


  // Filter expense

  RxList filterList = [].obs;

  Future<void> load_FilteredDB({cate,filterBy}) async {
    filterList.value = await Expensifier_DB_Helper.expense_db.readFilteredDB(cate: cate,filterBy: filterBy);

    if(filterList.value == null)
      {

      }
  }

  // void loadFilterList()
  // {
  //   if(filterList.isEmpty)
  //     {
  //       filterList.value = itemList.value;
  //     }
  //   else
  //     {
  //
  //     }
  // }



// ***************     Filter DATA   *************************

//       **     FilterBy      *************
  List<String> filterByList = [ "Income", "Expense", "Transfer"];
  RxString selectedFilterBy = "".obs;
  Rx<Color> selFilterByColorText = Color(0xff0D0E0F).obs;
  Rx<Color> selFilterByColorBox = Color(0xffE3E5E5).obs;
  RxInt selectedIndexFilterBy = 10.obs;

  void selectionFilterBy(int index) {

    if(selectedIndexFilterBy.value == index )
      {
        selectedIndexFilterBy.value = -1;
        selectedFilterBy.value = "";
      }
    else
      {
        selectedIndexFilterBy.value = index;
        selectedFilterBy.value = filterByList[index];
      }
    // print ("selected index = ${selectedIndex.value}");
    // print("selected filterby ==> ${selectedFilterBy.value}"  );
  }


//       **    SortBy      *************
  RxString selectedSortBy = "".obs;
  List<String> sortByList = [ "Highest", "Lowest", "Newest", "Oldest"];
  Rx<Color> selSortByColorText = Color(0xff0D0E0F).obs;
  Rx<Color> selSortByColorBox = Color(0xffE3E5E5).obs;
  RxInt selectedIndexSortBy = 10.obs;

  void selectionSortBy(int index) {
    if(selectedIndexSortBy.value == index)
      {
        selectedIndexSortBy.value = -1;
        selectedSortBy.value = "";
      }
    else
      {
        selectedIndexSortBy.value = index;
        selectedSortBy.value = sortByList[index];
      }
  }

//  **********   Filter Category      *************

  RxString selectedFilterCategory = "".obs;
// categoy list already exists above.....
  Rx<Color> selCategoryColorText = Color(0xff0D0E0F).obs;
  Rx<Color> selCategoryColorBox = Color(0xffE3E5E5).obs;
  RxInt selectedIndexCategory= 10.obs;

  void selectionCategory(int index)
  {
    if(selectedIndexCategory.value == index)
      {
        selectedIndexCategory.value = -1;
        selectedFilterCategory.value = "";
      }
    else
      {
        selectedIndexCategory.value = index;
        selectedFilterCategory.value = categoryList[index];
      }

    print("index  ${selectedIndexCategory.value} value = ${selectedFilterCategory.value}");

  }

// ***************     Filter DATA   *************************



// UPDATE


void updateFilterToItemList()
  {
    itemList.value = filterList ;
  }
}