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

    mapData = Get.arguments;

    index = mapData['index'];

    //control.selDate.value = control.filterList[id]['date'];

    tamount = TextEditingController(text: control.filterList[index]['amount']);
    tdesc = TextEditingController(text: control.filterList[index]['description']);

    if (control.filterList[index]['status'] == 'Income')
    {
      control.statusInUpdateScreen.value = "Income";
      control.expenseScreenBgColor.value = Color(0xff00A86B);
    }
    else if (control.filterList[index]['status'] == 'Expense')
    {
      control.statusInUpdateScreen.value = "Expense";
      control.expenseScreenBgColor.value = Color(0xffFD3C4A);
    }
    else if(control.filterList[index]['status'] == 'Transfer')
    {
      control.statusInUpdateScreen.value = "Tranfer";
      control.expenseScreenBgColor.value = Color(0xff0077FF);
    }

    // control.statusInUpdateScreen.value = control.filterList[index]['status'];
    // print(control.statusInUpdateScreen.value);
    control.selCategoryType.value = control.filterList[index]['category'];
    control.selWalletType.value = control.filterList[index]['paymentType'];

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

                  int delID = control.filterList[index]['id'] ;

                  await expense_db_helper.deleteInDB(delID);

                  control.updateFilterToItemList();

                  await control.load_ExpensifierDB();

                  Get.back();

                 },
              )],
        ),

        body: SingleChildScrollView(
          child: Stack(
            fit: StackFit.loose,
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

                       // hintText: "0",
                        hintStyle: TextStyle(
                            fontSize: 45.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                        border: InputBorder.none),
                  ),
                  Text(control.statusInUpdateScreen.value != "Income"
                      ? 'Buy the item of ${control.statusInUpdateScreen.value} '
                      : 'Gain from the ${control.statusInUpdateScreen.value} ',
                    style:  TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),),

                  SizedBox(height: 2.h,),


                  Text("${control.selDate.value} ${control.selTime.value}",style:  TextStyle(
                      fontSize: 11.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 3.h),
                    height: 10.h,width: 100.w,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w),color: Colors.amber,),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                    children: [
                          Obx(
                            () =>  Container(width: 40.w,alignment: Alignment.center,
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Category",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w300),),
                              Container(
                                height: 4.h,
                                width: 40.w,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 1.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.w),
                                ),
                                child: DropdownButton(
                                  borderRadius: BorderRadius.circular(5.w),
                                  // isExpanded: true,
                                  underline: Container(),
                                  icon:SizedBox.shrink(),
                                  value: control.selCategoryType.value,
                                  items: control.categoryList
                                      .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text("$e",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                                      alignment: Alignment.center))
                                      .toList(),
                                  onChanged: (value) {
                                    control.selCategoryType.value = value as String;
                                  },
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                          Obx(
                        () =>  Container(width: 35.w,
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Wallet",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w300),),
                              Container(
                                  height: 4.h,
                                  width: 35.w,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: DropdownButton(
                                    borderRadius: BorderRadius.circular(5.w),
                                    // isExpanded: true,
                                    underline: Container(),
                                    icon:SizedBox.shrink(),
                                    value: control.selWalletType.value,
                                    items: control.walletList
                                        .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text("$e",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                                        alignment: Alignment.centerLeft))
                                        .toList(),
                                    onChanged: (value) {
                                      control.selWalletType.value = value as String;
                                    },
                                  ),
                                ),


                            ],
                          ),
                        ),
                      ),


                    // DetailTile(title: "Type",dataList : control.statusList,variable: control.statusInUpdateScreen.value),
                    // DetailTile(title: "Category",dataList: control.categoryList, variable: control.selCategoryType.value),
                    // DetailTile(title: "Wallet",dataList: control.walletList,variable: control.selWalletType.value),
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

                      TextField(
                        controller: tdesc,
                        textAlign: TextAlign.justify,
                        maxLines: 2,
                        keyboardType: TextInputType.number,
                        // showCursor: false,
                        cursorColor: Colors.white,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,fontSize: 15.sp,
                            overflow: TextOverflow.ellipsis),
                        decoration: InputDecoration(
                          // prefixText: '\$',
                          //   prefixStyle: TextStyle(
                          //       fontSize: 40.sp,
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.w600),

                          // hintText: "0",
                          //   hintStyle: TextStyle(
                          //       fontSize: 45.sp,
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.w600),
                            border: InputBorder.none),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.5.h),
                        child: Text("Attachment",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w400,color: Colors.black45),),
                      ),
                      Container(height: 18.h,width: 100.w,
                        margin: EdgeInsets.symmetric(vertical: 1.5.h),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.w),color: Colors.amber.shade50,
                      image: DecorationImage(image:AssetImage("assets/images/image.png"),fit: BoxFit.fill)),
                      ),


                      GestureDetector(
                        onTap: () async {
                          Expensifier_DB_Helper expense_db_helper = Expensifier_DB_Helper();

                          ExpenseModel model = ExpenseModel(
                            id:control.filterList[index]['id'],
                            amount: int.parse(tamount.text),
                            category: control.selCategoryType.value,
                            status: control.statusInUpdateScreen.value,
                            description: tdesc.text,
                            paymentType: control.selWalletType.value,
                            time: "10.00 AM",
                            date: "21/07/2025",
                          );

                         await expense_db_helper.updateInDB(model);

                         control.updateFilterToItemList();

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
      ),
    );
  }

  // Widget DetailTile({title,dataList,variable}) {
  //   return Container(width: 25.w,
  //                   child: Column(mainAxisSize: MainAxisSize.min,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Text("Type",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w300),),
  //                       Container(
  //                         height: 4.h,
  //                         width: 30.w,
  //                         alignment: Alignment.center,
  //                         padding: EdgeInsets.symmetric(horizontal: 3.w),
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(5.w),
  //                             border: Border.all(color: Colors.black12)),
  //                         child: DropdownButton(
  //                           borderRadius: BorderRadius.circular(5.w),
  //                           // isExpanded: true,
  //                           underline: Container(),
  //                           icon:SizedBox.shrink(),
  //                           value: control.statusInUpdateScreen.value,
  //                           items: control.statusList
  //                               .map((e) => DropdownMenuItem(
  //                               value: e,
  //                               child: Text("$e"),
  //                               alignment: Alignment.centerLeft))
  //                               .toList(),
  //                           onChanged: (value) {
  //                             control.statusInUpdateScreen.value = value as String;
  //                           },
  //                         ),
  //                       ),
  //
  //                     ],
  //                   ),
  //                 );
  // }


}
