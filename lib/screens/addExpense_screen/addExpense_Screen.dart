import 'package:expensifier/controller/expensifier_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  TextEditingController tamount = TextEditingController();
  TextEditingController tdesc = TextEditingController();

  ExpensifierController control = Get.put(ExpensifierController());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.redAccent,

        appBar: AppBar(
          elevation: 0,backgroundColor: Colors.redAccent,
          leading: IconButton(icon:Icon(Icons.arrow_back_outlined),
              iconSize: 16.sp,
              color: Colors.white,
              onPressed: () => Get.back(),),),

        body: Column(
          children: [

            Text("How much?",style: TextStyle(fontSize: 16.sp,color: Colors.white70,fontWeight: FontWeight.w400),),
            TextField(
              controller: tamount,
              keyboardType: TextInputType.number,
              showCursor: false,
              style: TextStyle(fontSize: 40.sp,color: Colors.white,fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                 prefixIcon: Padding(padding: EdgeInsets.all(0), child: Text('\$',style: TextStyle(fontSize: 40.sp,color: Colors.white,fontWeight: FontWeight.w600),)),
                hintText: "0",
                hintStyle: TextStyle(fontSize: 40.sp,color: Colors.white,fontWeight: FontWeight.w600),

                border: InputBorder.none
              ),
            ),

            Container(height: 60.h,width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.w),
                    topRight: Radius.circular(5.w),
                ),
                  color: Colors.white

                ),

                child: Column(
                  children: [
                    DropdownButton(

                      value: control.selCategoryType.value,
                      items: control.categoryList.map((e) =>
                        DropdownMenuItem(
                          value: e,
                            child: Text("$e"),
                            alignment: Alignment.centerLeft)
                        ).toList(),
                      onChanged: (value) {
                      control.selCategoryType.value = value as String;
                     },
                    ),


                    TextField(
                      controller: tdesc,
                      keyboardType: TextInputType.text,
                     // showCursor: false,
                      style: TextStyle(fontSize: 15.sp,color: Colors.black54,fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          hintText: "Description",
                          hintStyle: TextStyle(fontSize: 14.sp,color: Colors.black38,fontWeight: FontWeight.w300),

                          border: InputBorder.none
                      ),
                    ),


                  ]
                ),
              )


          ],
        ),

      ),
    );
  }
}
