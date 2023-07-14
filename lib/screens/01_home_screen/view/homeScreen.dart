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

    control.loadTotalFind();
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
                CircleAvatar(backgroundImage: AssetImage("assets/images/person.png",),radius: 5.w,),
                IconButton(icon:Icon(Icons.notification_add_rounded),onPressed: () {
                    control.loadTotalFind();
                  },),
              ],),

              Container(alignment: Alignment.center,margin: EdgeInsets.symmetric(vertical: 1.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Account Balance",style: TextStyle(fontSize: 13.sp,color: Colors.black38),),

                    Text("\$ 91066154",style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),



              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () =>  transactionTypeTab(title: "Income",colour:Color(0xff00A86B),
                        amount:control.additionIncome.value ,
                        image: "assets/images/first/Income.png" ),
                  ),
                  transactionTypeTab(title: "Expense",colour:Color(0xffFD3C4A),
                      amount:control.additionExpense.value ,
                      image: "assets/images/first/Expense.png" ),
                ],
              ),

              Padding(
                padding:  EdgeInsets.symmetric(vertical: 1.h),
                child: Text("Spend Frequency",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15.sp,),),
              ),

              Container(height: 23.h,width: 100.w,alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.w),
                  image: DecorationImage(image: AssetImage("assets/images/Graph.png"),fit: BoxFit.fill),),),

              Padding(
                padding:  EdgeInsets.symmetric(vertical: 1.h),
                child: Text("Recent Transaction",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15.sp,),),
              ),

              Obx(
                () =>  control.itemList.isEmpty?Container():ListView.builder(
                    itemCount: 4,
                    reverse: true,
                    shrinkWrap:true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {

                      control.selCategoryTab(control.itemList[index]['category']);
                      return ItemListTile(
                          amount: control.itemList[index]['amount'],
                          status: control.itemList[index]['status'],
                          category: control.itemList[index]['category'],
                          paymentType: control.itemList[index]['paymentType'],
                          categoryImg: control.selCategoryImgPath.value,
                          categoryColor: control.selCategoryBg.value
                      );
                    },),
              ),

            ],
          ),
        ),
      ),

    );
  }

  Container transactionTypeTab({title, colour, amount, image}) {
    return Container(height: 11.h,width: 45.w,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 2.w,right: 1.w),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.w),
            color: colour),
          child: Row(
            children: [
              Container(height: 7.h,width: 7.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.w),
              image: DecorationImage(image: AssetImage("$image"),fit: BoxFit.fill),
              color: colour),),

              SizedBox(width:2.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("$title",style: TextStyle(fontSize: 13.sp,color: Colors.white,fontWeight: FontWeight.w300)),
                Text(amount == "" ? "\$ 0" : "\$ $amount",style: TextStyle(fontSize: 16.sp,color: Colors.white),)
              ],)
          ],),

          );
  }


  Widget ItemListTile({category,paymentType,amount,time,categoryImg,categoryColor,status})
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
                    Text("$category",style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),),
                    Text(status=='Income'?" \$ $amount":"- \$ $amount",style: TextStyle(color: status=='Income'?Colors.green:Colors.red),)
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("$paymentType"),
                    Text("10.00 AM")
                  ],
                ),
              ],),
          )
        ],
      ),
    );
  }
}
