import 'package:expensifier/controller/expensifier_Controller.dart';
import 'package:expensifier/model/expense_model.dart';
import 'package:expensifier/utils/expensifier_database_sqflite_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class UpdateExpense_DATA extends StatefulWidget {
  const UpdateExpense_DATA({super.key});

  @override
  State<UpdateExpense_DATA> createState() => _UpdateExpense_DATAState();
}

class _UpdateExpense_DATAState extends State<UpdateExpense_DATA> {

  TextEditingController tamount = TextEditingController();
  TextEditingController tdesc = TextEditingController();

  ExpensifierController control = Get.put(ExpensifierController());

  Map mapData = {};

  int index = 0;

  @override
  void initState() {
    super.initState();
    control.load_ExpensifierDB();

    mapData = Get.arguments;

    index = int.parse(mapData['id']);

    //control.selDate.value = control.itemList[id]['date'];

    tamount = TextEditingController(text: control.itemList[index]['amount']);

    if (mapData['status'] == 'income')
    {
      control.expenseScreenBgColor.value = Color(0xff00A86B);
    }

    else if (mapData['status'] == 'expense')
    {
      control.expenseScreenBgColor.value = Color(0xffFD3C4A);
    }

    else if(mapData['status'] == 'transfer')
    {
      control.expenseScreenBgColor.value = Color(0xff0077FF);
    }


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: control.expenseScreenBgColor.value,
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace_rounded),
              iconSize: 25.sp,
              color: Colors.white,
              onPressed: () => Get.back(),
            ),
            centerTitle: true,
            title: Text("Detail Transaction",
              style: TextStyle(color: Colors.white,fontSize: 18.sp),),
            actions: [
              IconButton(
                icon: Icon(Icons.delete_outline_rounded),iconSize: 25.sp,color: Colors.white,
                onPressed: () async {
                  Expensifier_DB_Helper expense_db_helper = Expensifier_DB_Helper();

                  await expense_db_helper.deleteInDB(1);
                  await control.load_ExpensifierDB();

                 },
              )],
        ),

        body: Stack(
          children: [
            Container(height: 30.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.w),
                bottomRight: Radius.circular(10.w),
              ),
                color: control.expenseScreenBgColor.value,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.center,
                children: [
                TextField(
                  controller: tamount,
                  textAlign: TextAlign.center,

                  keyboardType: TextInputType.number,
                  // showCursor: false,
                  cursorColor: Colors.white,
                  style: TextStyle(
                      fontSize: 45.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    // prefixText: '\$',
                    //   prefixStyle: TextStyle(
                    //       fontSize: 40.sp,
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.w600),

                      hintText: "0",
                      hintStyle: TextStyle(
                          fontSize: 45.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                      border: InputBorder.none),
                ),
                Text("Buy sdfsdfsdfdfk",style:  TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),),
                SizedBox(height: 2.h,),


                Text("${control.selDate.value} ${control.selTime.value}",style:  TextStyle(
                    fontSize: 11.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),),

                Container(margin: EdgeInsets.symmetric(vertical: 3.h),height: 10.h,width: 100.w,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w),color: Colors.amber,),
                child: Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [
                  DetailTile(title: "Type",titledata: "Expense"),
                  DetailTile(title: "Category",titledata: "Shopping"),
                  DetailTile(title: "Wallet",titledata: "Wallet"),
                ],),
                ),

                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(color: Colors.black12,thickness: 1.5,height: 0.5.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.5.h),
                      child: Text("Description",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w400,color: Colors.black45),),
                    ),

                    Text("Data \nsf\nsdf\nOf",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15.sp,overflow: TextOverflow.ellipsis),textAlign: TextAlign.justify,maxLines: 2,),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.5.h),
                      child: Text("Attachment",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w400,color: Colors.black45),),
                    ),
                    Container(height: 18.h,width: 100.w,
                      margin: EdgeInsets.symmetric(vertical: 1.5.h),
                      child: Text("Image"),alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.w),color: Colors.amber.shade50,),
                    ),


                    GestureDetector(
                      onTap: () {
                        Expensifier_DB_Helper expense_db_helper = Expensifier_DB_Helper();

                        ExpenseModel model = ExpenseModel(
                         //  amount: control.itemList[index]['amount'],
                         //  category: control.itemList[index]['category'],
                         //  status: control.itemList[id]['status'],
                         // // description: control.itemList[id]['description'],
                         //  paymentType: control.itemList[id]['paymentType'],
                         //  time: ,
                         //  date: ,

                        );

                        expense_db_helper.updateInDB(model);
                      },
                      child: Container(
                        height: 8.h,
                        width: 100.w,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.w),
                            color: Color(0xff7F3DFF),
                            border: Border.all(color: Colors.black12)),
                        child: Text(
                          "Edit",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp,
                              color: Colors.white),
                        ),
                      ),
                    ),

                  ],
                ),


              ],),
            )

          ],
        ),
      ),
    );
  }

  Widget DetailTile({title,titledata})
  {
    return Container(width: 25.w,
      child: Column(mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("$title",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w300),),
          Text("$titledata",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }

}
