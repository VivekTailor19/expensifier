import 'dart:math';

import 'package:expensifier/controller/expensifier_Controller.dart';
import 'package:expensifier/model/expense_model.dart';
import 'package:expensifier/utils/expensifier_database_sqflite_helper.dart';
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

  Map mapData = {};


  @override
  void initState() {
    super.initState();

    control.selDate.value = control.setDateFormat(DateTime.now());

    mapData = Get.arguments;

    if (mapData['status'] == 'income')
    {
      control.expenseScreenBgColor.value = Color(0xff00A86B);
      control.titleAddScreen.value = "Income";
    }

    else if (mapData['status'] == 'expense')
    {
      control.expenseScreenBgColor.value = Color(0xffFD3C4A);
      control.titleAddScreen.value = "Expense";
    }

    else if(mapData['status'] == 'transfer')
      {
        control.expenseScreenBgColor.value = Color(0xff0077FF);
        control.titleAddScreen.value = "Transfer";
      }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: control.expenseScreenBgColor.value,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: control.expenseScreenBgColor.value,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            iconSize: 16.sp,
            color: Colors.white,
            onPressed: () => Get.back(),
          ),

          title: Text("${control.titleAddScreen.value}",style: TextStyle(color: Colors.white,fontSize: 18.sp),)
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            mapData['status'] != 'transfer'
                ? SizedBox(height: 5.h,)
                :SizedBox(height: 26.9.h,),

            Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How much?",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white70,
                          fontWeight: FontWeight.w400),
                    ),
                    TextField(
                      controller: tamount,
                      keyboardType: TextInputType.number,
                      showCursor: false,
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                '\$',
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )),
                          hintText: "0",
                          hintStyle: TextStyle(
                              fontSize: 40.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                          border: InputBorder.none),
                    ),
                  ],
                )),

            mapData['status'] != 'transfer'

                ? SingleChildScrollView(
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.w),
                      topRight: Radius.circular(10.w),
                    ),
                    color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(children: [
                  SizedBox(height: 5.h),
                  Obx(
                    () => Container(
                      height: 8.h,
                      width: 100.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.w),
                          border: Border.all(color: Colors.black12)),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(5.w),

                        // dropdownColor: Colors.amber,
                        isExpanded: true,
                        icon: Icon(Icons.expand_more_rounded),
                        underline: Container(),

                        value: control.selCategoryType.value,
                        items: control.categoryList
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text("$e"),
                                alignment: Alignment.centerLeft))
                            .toList(),
                        onChanged: (value) {
                          control.selCategoryType.value = value as String;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  TextField(
                    controller: tdesc,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: "Description",
                      hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black38,
                          fontWeight: FontWeight.w200),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.w),
                          borderSide: BorderSide(color: Colors.black12)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.w),
                          borderSide: BorderSide(color: Colors.black12)),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    height: 8.h,
                    width: 100.w,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.w),
                        border: Border.all(color: Colors.black12)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(
                            angle: pi / 4,
                            child: Icon(
                              Icons.attach_file_rounded,
                              size: 20,
                            )),
                        SizedBox(width: 2.w),
                        Text(
                          "Add attachment",
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 15.sp),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    height: 8.h,
                    width: 100.w,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.w),
                        ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          GestureDetector(
                            onTap: () async {
                              DateTime? selectdate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2001),
                                  lastDate: DateTime(2050));

                              control.selDate.value = control.setDateFormat(selectdate!);

                            },
                            child: Row( mainAxisSize: MainAxisSize.min,
                              children: [

                                Icon(Icons.calendar_month_rounded,size: 30.sp,color: Color(0xff7A7E80)),
                                SizedBox(width: 2.w,),
                                Obx(() => Text("${control.selDate.value}",style: TextStyle(fontSize: 12.sp),)),

                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: () async {
                              TimeOfDay? selecttime = await showTimePicker(
                                  context: context, initialTime: TimeOfDay.now());
                              control.selTime.value = "$selecttime";
                            },
                            child: Row( mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.watch_later_outlined,size: 30.sp,color: Color(0xff7A7E80)),
                                SizedBox(width: 2.w,),
                                Obx(() =>  Text("${control.selTime.value}",style: TextStyle(fontSize: 12.sp),)),
                              ],
                            ),
                          ),



                        ],
                      ),
                  ),
                  SizedBox(height: 2.h),
                  Obx(
                    () => Container(
                      height: 8.h,
                      width: 100.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.w),
                          border: Border.all(color: Colors.black12)),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(5.w),

                        // dropdownColor: Colors.amber,
                        isExpanded: true,
                        icon: Icon(Icons.expand_more_rounded),
                        underline: Container(),

                        value: control.selWalletType.value,
                        items: control.walletList
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text("$e"),
                                alignment: Alignment.centerLeft))
                            .toList(),
                        onChanged: (value) {
                          control.selWalletType.value = value as String;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  GestureDetector(

                    onTap: () async {
                      Expensifier_DB_Helper expense_db_helper =
                          Expensifier_DB_Helper();

                      ExpenseModel model = ExpenseModel(
                          amount: int.parse(tamount.text),
                          status: mapData['status'],
                          category: control.selCategoryType.value,
                          description: tdesc.text,
                          paymentType: control.selWalletType.value,
                          date: control.selDate.value,
                          time: control.selTime.value

                      );

                      await expense_db_helper.insertInDB(model);

                      await control.load_ExpensifierDB();

                      Get.back();
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
                        "Continue",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.sp,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                ]),
              ),
            )

                : SingleChildScrollView(
              child: Container(
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.w),
                      topRight: Radius.circular(10.w),
                    ),
                    color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(children: [
                  SizedBox(height: 5.h),
                  Obx(
                        () => Stack(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 8.h,
                                width: 40.w,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.w),
                                          border: Border.all(color: Colors.black12)),
                                child: DropdownButton(

                                        borderRadius: BorderRadius.circular(5.w),

                                        // dropdownColor: Colors.amber,
                                        isExpanded: true,
                                        icon: Icon(Icons.expand_more_rounded,size: 0,),
                                        underline: Container(),

                                        value: control.selTransferFrom.value,
                                        items: control.walletList
                                            .map((e) => DropdownMenuItem(
                                            value: e,
                                  child: Center(child: Text("$e")),
                                  alignment: Alignment.centerLeft))
                                  .toList(),
                              onChanged: (value) {
                                control.selTransferFrom.value = value as String;
                              },
                      ),
                    ),
                              Container(
                      height: 8.h,
                      width: 40.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                border: Border.all(color: Colors.black12)),
                      child: DropdownButton(
                              borderRadius: BorderRadius.circular(5.w),

                              // dropdownColor: Colors.amber,
                              isExpanded: true,
                              icon: Icon(Icons.expand_more_rounded,size: 0,),
                              underline: Container(),

                              value: control.selTransferTo.value,
                              items: control.walletList
                                  .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Center(child: Text("$e")),
                                  alignment: Alignment.centerLeft))
                                  .toList(),
                              onChanged: (value) {
                                control.selTransferTo.value = value as String;
                              },
                      ),
                    ),
                            ],
                          ),
                            Align(alignment: Alignment(0,0),
                              child: Container(height: 15.w,width: 15.w,
                                  decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Color(0xffF1F1FA),width: 1 )),
                                child: CircleAvatar(radius: 3.w,backgroundImage: AssetImage("assets/images/first/transfer.png"),backgroundColor: Colors.white,),

                            ),
                            )
                      ],
                  ),
                        ),
                  SizedBox(height: 2.h),
                  TextField(
                    controller: tdesc,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: "Description",
                      hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black38,
                          fontWeight: FontWeight.w200),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.w),
                          borderSide: BorderSide(color: Colors.black12)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.w),
                          borderSide: BorderSide(color: Colors.black12)),
                    ),
                  ),                             //  description
                  SizedBox(height: 2.h),
                  Container(
                    height: 8.h,
                    width: 100.w,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.w),
                        border: Border.all(color: Colors.black12)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(
                            angle: pi / 4,
                            child: Icon(
                              Icons.attach_file_rounded,
                              size: 20,
                            )),
                        SizedBox(width: 2.w),
                        Text(
                          "Add attachment",
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 15.sp),
                        )
                      ],
                    ),
                  ),                             //  attachment
                  SizedBox(height: 2.h),
                  GestureDetector(
                    onTap: () async {

                      await control.load_ExpensifierDB();
                      Get.back();
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
                        "Continue",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.sp,
                            color: Colors.white),
                      ),
                    ),
                  ),                        //  continue
                  SizedBox(height: 2.h),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
