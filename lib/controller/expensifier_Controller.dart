import 'package:expensifier/utils/expensifier_database_sqflite_helper.dart';
import 'package:get/get.dart';

class ExpensifierController extends GetxController
{

  RxInt indexBottomBar = 0.obs;



  Future<void> load_ExpensifierDB()
  async {
     Expensifier_DB_Helper.expense_db.readFromDB();
  }

  RxString selCategoryType = 'Food'.obs;
  List<String> categoryList = ['Food','Subscription','Travel','Ticket-Booking','Shopping','Furniture','Vehicle','Fees','Study'];

  RxString selWalletType = 'PayTM'.obs;
  List<String> walletList = ['PayTM','PayPal','PhonePay','GooglePay','BHIM',];

}