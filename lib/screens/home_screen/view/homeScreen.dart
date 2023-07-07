import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("HomeScreen"),),


        body: Column(crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
              CircleAvatar(backgroundColor: Colors.red,radius: 5.w,),
                Icon(Icons.notification_add_rounded),
            ],),

            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                transactionTypeTab(title: "Income",amount: 50000,colour:Colors.green ),
                transactionTypeTab(title: "Expense",amount: 5000,colour:Colors.red ),
              ],
            ),

            Text("Spend Frequency",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15.sp,),),

            Container(height: 25.h,width: 100.w,color: Colors.amber.shade50,child: Text("Chart"),alignment: Alignment.center,),

            Text("Recent Transaction",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15.sp,),),



          ],
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
}
