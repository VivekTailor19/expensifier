import 'package:expensifier/controller/expensifier_Controller.dart';
import 'package:expensifier/utils/expensifier_database_sqflite_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {

  ExpensifierController control = Get.put(ExpensifierController());

  @override
  void initState() {
    super.initState();
    control.load_ExpensifierDB();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       body: SingleChildScrollView(
         child: Padding(
           padding:  EdgeInsets.symmetric(horizontal: 3.w),
           child: Column(
             children: [
               SizedBox(height: 2.h,),

               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [

                   GestureDetector(
                     onTap: () {

                     },
                     child: Container(height: 4.h,width: 25.w,
                     alignment: Alignment.center,
                     child: Row(mainAxisSize: MainAxisSize.min,
                       children: [
                         Icon(Icons.keyboard_arrow_down_rounded,size: 20.sp,color: Color(0xff7F3DFF),),
                         Text("Month",style: TextStyle(fontWeight: FontWeight.w400),),
                       ],
                     ),
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.w),
                     border: Border.all(color: Colors.black12,width: 0.5)),),
                   ),

                   GestureDetector(
                     onTap:  () {
                       Get.bottomSheet(
                           Container(
                             height: 60.h,width: 100.w, decoration: BoxDecoration(color: Colors.white,
                         borderRadius: BorderRadius.only(topLeft: Radius.circular(8.w),topRight: Radius.circular(8.w))),
                             child: Padding(
                               padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 3.h),
                               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                   Text("Filter Transaction",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.sp),),
                                   Container(height: 4.h,width: 20.w,alignment:Alignment.center,
                                     decoration: BoxDecoration(color: Colors.indigo.shade100,borderRadius: BorderRadius.circular(2.h)),

                                     child:Text("Reset",style: TextStyle(color: Colors.indigo,fontSize: 14.sp,fontWeight: FontWeight.w300),),)
                                 ],),

                                 Text("Filter By",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15.sp),),

                                 Obx(
                                   () =>  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                     children: [
                                     SelectionOptionTile(title: "Income",textColor: control.selIncomeTextColor.value,tileBg: control.selIncomeBoxColor.value),
                                     SelectionOptionTile(title: "Expense",textColor: control.selExpenseTextColor.value,tileBg: control.selExpenseBoxColor.value),
                                     SelectionOptionTile(title: "Transfer",textColor: control.selTransferTextColor.value,tileBg: control.selTransferBoxColor.value),
                                   ],),
                                 ),



                                 Text("Sort By",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15.sp),),

                                 Text("Category",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15.sp),),

                                 GestureDetector(
                                   onTap: () {
                                     control.load_FilteredDB(control.selFilterCategory.value);
                                   },
                                   child: Container(height: 7.h,width: 100.w,alignment: Alignment.center,
                                       padding: EdgeInsets.symmetric(horizontal: 5.w),
                                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.w),
                                           color: Color(0xff7F3DFF),
                                           border: Border.all(color: Colors.black12)),
                                       child: Text("Apply",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17.sp,color: Colors.white),),
                                     ),
                                 )

                               ],),
                             ),
                       ),
                           backgroundColor: Colors.transparent,
                       );
                     },
                     child: Container(height: 4.5.h,width: 5.h,
                     alignment: Alignment.center,
                     child: Icon(Icons.filter_list_rounded,size: 20.sp,color: Color(0xff7F3DFF)),
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.w),
                     border: Border.all(color: Colors.black12,width: 0.5)),),
                   ),
                 ],
               ),

               Container(height: 5.h,width: 100.w,
                 alignment: Alignment.center,
                 padding: EdgeInsets.all(3.w),
                 margin: EdgeInsets.symmetric(vertical:2.h),
                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("See your financial report",style: TextStyle(color:Color(0xff7F3DFF)),),
                     Icon(Icons.arrow_forward_ios_rounded,size: 16.sp,color: Color(0xff7F3DFF)),
                   ],
                 ),
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.5.w),color: Color(0xffEEE5FF),
                     ),),


               ListView.builder(
                 itemCount: control.itemList.length,
                 reverse: true,
                 shrinkWrap:true,
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder: (context, index) {
                   control.selCategoryTab(control.itemList[index]['category']);

                   return GestureDetector(

                     onDoubleTap: ()  async {
                       Expensifier_DB_Helper expense_db_helper = Expensifier_DB_Helper();
                       int delId = control.itemList[index]['id'];

                       print(delId);
                       await  expense_db_helper.deleteInDB(delId);
                       control.load_ExpensifierDB();

                     },
                     onLongPress: () {
                     },
                     child: ItemListTile(
                       amount: control.itemList[index]['amount'],
                       status: control.itemList[index]['status'],
                       category: control.itemList[index]['category'],
                       desc: control.itemList[index]['description'],
                       categoryImg: control.selCategoryImgPath.value,
                       categoryColor: control.selCategoryBg.value
                     ),
                   );
                 },),
             ],
           ),
         ),
       )
      ),
    );
  }

  Widget ItemListTile({category,desc,amount,time,categoryImg,categoryColor,status})
  {
    return  Container(height: 8.h,width: 100.w,
        margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.5.h),
        padding: EdgeInsets.symmetric(horizontal: 1.5.w,),
        child: Row(
          children: [
            Container(height: 8.h,width: 8.h,
              alignment: Alignment.center,
              child: Image.asset("$categoryImg",height: 5.h,),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.w),color: categoryColor),),
            SizedBox(width: 3.w,),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$category"),
                      Text(status=='income'?" ₹ $amount":"- ₹ $amount",style: TextStyle(color: status=='income'?Colors.green:Colors.red),)
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$desc"),Text("Time 10.00 AM")
                    ],
                  ),

                ],),
            ),

          ],
        ),
      );
  }

  Widget SelectionOptionTile({title,textColor,tileBg})
  {
    return GestureDetector(
      onTap: () {
        print(title);
        control.selectFilterByExpense(title);
      },
      child: Container(height: 5.h,width: 25.w,alignment:Alignment.center,
        decoration: BoxDecoration(color: tileBg,borderRadius: BorderRadius.circular(2.5.h),border: Border.all(color: Colors.black12)),

        child:Text("$title",style: TextStyle(color: textColor,fontSize: 14.sp,fontWeight: FontWeight.w300),),),
    );
  }

}
