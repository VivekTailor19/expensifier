import 'package:expensifier/controller/expensifier_Controller.dart';
import 'package:flutter/cupertino.dart';
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

  ExpensifierController control = Get.put(ExpensifierController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: control.expenseScreenBgColor.value,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              iconSize: 16.sp,
              color: Colors.white,
              onPressed: () => Get.back(),
            ),
            centerTitle: true,

            title: Text("Detail Transaction",style: TextStyle(color: Colors.white,fontSize: 18.sp),)
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

                Divider(color: Colors.black12,thickness: 1.5,),

                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Description",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,color: Colors.black45),),
                  ],
                ),


                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Attachment",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,color: Colors.black45),),
                  ],
                )



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
