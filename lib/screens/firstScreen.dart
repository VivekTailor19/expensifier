import 'package:expensifier/controller/expensifier_Controller.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

          body:Obx(() =>  control.screenList[control.indexBottomBar.value]),

          floatingActionButton:  SizedBox(
            height: 55,
            width: 55,
            ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

          bottomNavigationBar: AnimatedBottomNavigationBar(

            barColor: Colors.white,
            controller: FloatingBottomBarController(initialIndex:control.indexBottomBar.value,),
            bottomBar: [
              CustombuildBottomBarItem("Home",Icons.home_rounded),
              CustombuildBottomBarItem("Transaction",Icons.multiple_stop_rounded),
              CustombuildBottomBarItem("Budget",Icons.pie_chart_rounded),
              CustombuildBottomBarItem("Person",Icons.person_2_rounded),

            ],



            bottomBarCenterModel: BottomBarCenterModel(

              centerBackgroundColor: Color(0xff7F3DFF),
              centerIcon: const FloatingCenterButton(
                child: Icon(
                  Icons.add_sharp,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              centerIconChild: [

                FloatingCenterButtonChild(
                  child: CircleAvatar(radius: 25,backgroundImage: AssetImage("assets/images/first/Transaction.png"),),
                  onTap: () => Get.toNamed("/expense"),
                ),
                FloatingCenterButtonChild(
                  child: CircleAvatar(radius: 25,backgroundImage: AssetImage("assets/images/first/Income.png")),
                  onTap: () => Get.toNamed("/expense",arguments: {"status":"income"}),
                ),
                FloatingCenterButtonChild(
                  child: CircleAvatar(radius: 25,backgroundImage: AssetImage("assets/images/first/Expense.png"),),
                  onTap: () => Get.toNamed("/expense",arguments: {"status":"expense"}),
                ),


              ],
            ),
          ),

        ),


    );
  }

  BottomBarItem CustombuildBottomBarItem(String titledata,IconData icondata) {
    return BottomBarItem(
            icon:  Icon(icondata, size: 30,color: Color(0xffC6C6C6)),
            iconSelected: Icon(icondata,
                color: Color(0xff7F3DFF),
                size: 30),

            title: titledata,
            titleStyle: TextStyle(fontSize: 12.5,fontWeight: FontWeight.w500),
            dotColor: Colors.white,
            onTap: (value) {
              control.indexBottomBar.value = value;
              print(control.indexBottomBar.value);
            }
            );
  }
}



