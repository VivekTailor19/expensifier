import 'package:expensifier/controller/expensifier_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ExpensifierController control = Get.put(ExpensifierController());

  @override
  void initState() {
    super.initState();
    control.load_ExpensifierDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 3.w),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              SizedBox(height: 2.h,),
              Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                CircleAvatar(backgroundColor: Colors.red,radius: 5.w,),
                  Icon(Icons.notification_add_rounded),
              ],),

              Container(alignment: Alignment.center,margin: EdgeInsets.symmetric(vertical: 1.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Account Balance",style: TextStyle(fontSize: 13.sp,color: Colors.black38),),

                    Text("₹ 9400",style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),



              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  transactionTypeTab(title: "Income",amount: 50000,colour:Color(0xff00A86B) ),
                  transactionTypeTab(title: "Expense",amount: 5000,colour:Colors.red ),
                ],
              ),

              Padding(
                padding:  EdgeInsets.symmetric(vertical: 1.h),
                child: Text("Spend Frequency",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15.sp,),),
              ),

              Container(height: 23.h,width: 100.w,color: Colors.amber.shade50,child: Text("Chart"),alignment: Alignment.center,),

              Padding(
                padding:  EdgeInsets.symmetric(vertical: 1.h),
                child: Text("Recent Transaction",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15.sp,),),
              ),

              ListView.builder(
                itemCount: 1,
                reverse: true,
                shrinkWrap:true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  control.selCategoryTab(control.itemList[index]['category']);
                  return ItemListTile(
                      amount: control.itemList[index]['amount'],
                      status: control.itemList[index]['status'],
                      category: control.itemList[index]['category'],
                      desc: control.itemList[index]['description'],
                      categoryImg: control.selCategoryImgPath.value,
                      categoryColor: control.selCategoryBg.value
                  );
                },),



            ],
          ),
        ),
      ),

    );
  }

  Container transactionTypeTab({title, colour, amount, image}) {
    return Container(height: 11.h,width: 45.w,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 3.w,right: 1.w),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.w),
            color: colour),
          child: Row(
            children: [
              Container(height: 6.h,width: 6.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.w),
              color: Colors.white),),

              SizedBox(width:3.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("$title",style: TextStyle(fontSize: 13.sp,color: Colors.white,fontWeight: FontWeight.w300)),
                Text("\$ $amount",style: TextStyle(fontSize: 16.sp,color: Colors.white),)
              ],)
          ],),

          );
  }


  Widget ItemListTile({category,desc,amount,time,categoryImg,categoryColor,status})
  {
    return Container(height: 8.h,width: 100.w,
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
          )
        ],
      ),
    );
  }
}
