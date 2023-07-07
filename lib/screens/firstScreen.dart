import 'dart:developer';

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
  Widget build(BuildContext context) {
    
    
    return SafeArea(

        child: Scaffold(


          // floatingActionButton: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     FloatingActionButton(
          //       child: Icon(Icons.person,size: 25.sp,color: Colors.white,),
          //       onPressed: () {
          //
          //       },
          //
          //     ),
          //     FloatingActionButton(
          //       child: Icon(Icons.add,size: 25.sp,color: Colors.white,),
          //       onPressed: () {
          //         Get.bottomSheet(backgroundColor: Colors.white,
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //               IconButton(onPressed: () {
          //                 Get.toNamed("/expense");
          //               }, icon: Icon(Icons.upload)),
          //               IconButton(onPressed: () {
          //                 Get.toNamed("/expense");
          //               }, icon: Icon(Icons.download))
          //         ],));
          //       },
          //
          //     ),
          //
          //   ],
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

          floatingActionButton: const SizedBox(
            height: 55,
            width: 55,
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

          bottomNavigationBar: AnimatedBottomNavigationBar(

            barColor: Colors.white,
            controller: FloatingBottomBarController(initialIndex:control.indexBottomBar.value, ),
            bottomBar: [
              CustombuildBottomBarItem("Home",Icons.home_rounded),
              CustombuildBottomBarItem("Transaction",Icons.multiple_stop_rounded),
              CustombuildBottomBarItem("Budget",Icons.pie_chart_rounded),
              CustombuildBottomBarItem("Person",Icons.person_2_rounded),

            ],


            bottomBarCenterModel: BottomBarCenterModel(

              centerBackgroundColor: Colors.indigo,
              centerIcon: const FloatingCenterButton(
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              centerIconChild: [

                FloatingCenterButtonChild(
                  child: CircleAvatar(radius: 20,backgroundImage: AssetImage("assets/first/currency.png"),backgroundColor: Color(0xff0077FF),),
                  onTap: () => Get.toNamed("/expense"),
                ),FloatingCenterButtonChild(
                  child: CircleAvatar(radius: 20,backgroundImage: AssetImage("assets/first/income.png"),backgroundColor: Color(0xff00A86B)),
                  onTap: () => Get.toNamed("/expense"),
                ),FloatingCenterButtonChild(
                  child: CircleAvatar(radius: 20,backgroundImage: AssetImage("assets/first/expense.png"),backgroundColor: Colors.red),
                  onTap: () => Get.toNamed("/expense"),
                ),

              ],
            ),
          ),

        ),


    );
  }

  BottomBarItem CustombuildBottomBarItem(String titledata,IconData icondata) {
    return BottomBarItem(
            icon:  Icon(icondata, size: 30,color: Colors.black26),
            iconSelected: Icon(icondata,
                color: Colors.indigo,
                size: 30),

            title: titledata,
            titleStyle: TextStyle(fontSize: 13.5,fontWeight: FontWeight.w500),
            dotColor: Colors.white,
            onTap: (value) => control.indexBottomBar.value = value,
            );
  }
}
