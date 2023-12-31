import 'package:expensifier/controller/expensifier_Controller.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

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

          body:Obx(() =>  control.screenList[control.indexBottomBar.value]),


          floatingActionButton:
          FloatingActionButton(onPressed: () {

            Get.bottomSheet(backgroundColor: Colors.transparent,
              enableDrag: true,

              Container(height: 40.h,width: 100.w,color: Colors.transparent,
              alignment: Alignment.bottomCenter,
              child: Column(mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [

                  GestureDetector(onTap:() {
                    Get.back();
                    Get.toNamed("/expense",arguments: {"status":"transfer"});
                  },
                    child: MoneyItem(title: "Add",imgPath: "assets/images/first/Transaction.png")),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(onTap: () {
                        Get.back();
                        Get.toNamed("/expense",arguments: {"status":"income"});
                      },
                        child: MoneyItem(title: "Income",imgPath: "assets/images/first/Income.png")),

                      GestureDetector(onTap: () {
                        Get.back();
                        Get.toNamed("/expense",arguments: {"status":"expense"});
                       },
                        child: MoneyItem(title: "Expense",imgPath: "assets/images/first/Expense.png")),

                    ],
                  ),
                  GestureDetector(onTap:() =>  Get.back(),
                  child: MoneyItem(imgPath: "assets/images/first/close.png")),

                ],
              ),),
            );

            },
            child: Icon(Icons.add,size: 35.sp,color: Colors.white,),
            backgroundColor: Color(0xff7F3DFF),elevation: 0,),

          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,

          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 10,
            height: 60,

            elevation: 0,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    InkWell(
                      onTap: () {

                        control.indexBottomBar.value = 0;
                      },
                      child: SizedBox(width: 75,
                        child: Column(mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() =>  Icon(Icons.home_rounded, size: 30,color: control.indexBottomBar.value == 0 ? Color(0xff7F3DFF) : Color(0xffC6C6C6)  )),
                            Text("Home",style: TextStyle(color:Color(0xff7F3DFF),fontSize: 13.5 ),),
                          ],),
                      ),
                    ),
                  SizedBox(width: 1.w,),
                    InkWell(
                      onTap: () {
                        control.indexBottomBar.value = 1;
                      },
                      child: SizedBox(width: 75,
                        child: Column(mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() =>  Icon(Icons.receipt_long_rounded, size: 30,color: control.indexBottomBar.value == 1 ? Color(0xff7F3DFF) : Color(0xffC6C6C6)  )),
                            Text("Transaction",style: TextStyle(color:Color(0xff7F3DFF),fontSize: 13.5 ),),
                          ],),
                      ),
                    ),
                  Spacer(),


                    InkWell(
                      onTap: () {
                        control.indexBottomBar.value = 2;
                      },
                      child: SizedBox(width: 75,
                        child: Column(mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() =>  Icon(Icons.pie_chart, size: 30,color: control.indexBottomBar.value == 2 ? Color(0xff7F3DFF) : Color(0xffC6C6C6)  )),
                            Text("Budget",style: TextStyle(color:Color(0xff7F3DFF),fontSize: 13.5 ),),
                          ],),
                      ),
                    ),
                    SizedBox(width: 1.w,),

                    InkWell(
                      onTap: () {
                        control.indexBottomBar.value = 3;
                      },
                      child: SizedBox(width: 75,
                        child: Column(mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() =>  Icon(Icons.person, size: 30,color: control.indexBottomBar.value == 3 ? Color(0xff7F3DFF) : Color(0xffC6C6C6)  )),
                            Text("Profile",style: TextStyle(color:Color(0xff7F3DFF),fontSize: 13.5 ),),
                          ],),
                      ),
                    ),
    ],),
              ),
            ),

        ),


    );
  }

  InkWell BottomItem({index,iconData,title}) {
    return InkWell(
                        onTap: () {
                          control.indexBottomBar.value = index;
                    },
                      child: SizedBox(width: 75,
                        child: Column(mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() =>  Icon(iconData, size: 30,color: control.indexBottomBar.value == 0 ? Color(0xff7F3DFF) : Color(0xffC6C6C6)  )),

                            Text("$title",style: TextStyle(color:Color(0xff7F3DFF),fontSize: 13.5 ),),
                          ],),
                ),
              );
  }

  Widget MoneyItem({title,imgPath})
  {
    return Container(height: 28.w,width: 30.w,

       alignment: Alignment.bottomCenter,
      child: Column(mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(radius: 28.sp,backgroundImage: AssetImage("$imgPath"),backgroundColor: Color(0xff7F3DFF),),
          Text(title == null ? "":"$title",style: TextStyle(color: Colors.white,fontSize: 14.sp),)
        ],
      ),
    );
  }

  // Widget BottomItem({title,iconData,index})
  // {
  //   return InkWell(
  //     onTap: () {
  //       // control.indexBottomBar.value = index;
  //       if( control.indexBottomBar.value == index)
  //         {
  //           control.bottomColour.value = Color(0xff7F3DFF);
  //         }
  //       else
  //         {
  //           control.bottomColour.value = Color(0xffC6C6C6);
  //         }
  //       print(control.bottomColour.value);
  //     },
  //     child: SizedBox(width: 75,
  //       child: Column(mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Obx(() =>  Icon(iconData, size: 30,color: control.bottomColour.value )),
  //           Text("$title",style: TextStyle(color:Color(0xff7F3DFF),fontSize: 13.5 ),),
  //         ],),
  //     ),
  //   );
  // }

}




//AnimatedBottomNavigationBar(
//
//             barColor: Colors.white,
//             controller: FloatingBottomBarController(initialIndex:control.indexBottomBar.value,),
//             bottomBar: [
//               CustombuildBottomBarItem("Home",Icons.home_rounded),
//               CustombuildBottomBarItem("Transaction",Icons.multiple_stop_rounded),
//               CustombuildBottomBarItem("Budget",Icons.pie_chart_rounded),
//               CustombuildBottomBarItem("Person",Icons.person_2_rounded),
//
//             ],
//
//
//
//             bottomBarCenterModel: BottomBarCenterModel(
//
//               centerBackgroundColor: Color(0xff7F3DFF),
//               centerIcon: const FloatingCenterButton(
//                 child: Icon(
//                   Icons.add_sharp,
//                   color: Colors.white,
//                   size: 35,
//                 ),
//               ),
//               centerIconChild: [
//
//                 FloatingCenterButtonChild(
//                   child: CircleAvatar(radius: 25,backgroundImage: AssetImage("assets/images/first/Transaction.png"),),
//                   onTap: () => Get.toNamed("/expense"),
//                 ),
//                 FloatingCenterButtonChild(
//                   child: CircleAvatar(radius: 25,backgroundImage: AssetImage("assets/images/first/Income.png")),
//                   onTap: () => Get.toNamed("/expense",arguments: {"status":"income"}),
//                 ),
//                 FloatingCenterButtonChild(
//                   child: CircleAvatar(radius: 25,backgroundImage: AssetImage("assets/images/first/Expense.png"),),
//                   onTap: () => Get.toNamed("/expense",arguments: {"status":"expense"}),
//                 ),
//
//


//               ],
//             ),
//           ),

//



// BottomBarItem CustombuildBottomBarItem(String titledata,IconData icondata) {
//   return BottomBarItem(
//           icon:  Icon(icondata, size: 30,color: Color(0xffC6C6C6)),
//           iconSelected: Icon(icondata,
//               color: Color(0xff7F3DFF),
//               size: 30),
//
//           title: titledata,
//           titleStyle: TextStyle(fontSize: 12.5,fontWeight: FontWeight.w500),
//           dotColor: Colors.white,
//           onTap: (value) {
//             control.indexBottomBar.value = value;
//             print(control.indexBottomBar.value);
//           }
//           );
// }