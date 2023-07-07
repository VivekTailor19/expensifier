import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,size: 25.sp,color: Colors.white,),
          onPressed: () {
            Get.bottomSheet(backgroundColor: Colors.white,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  IconButton(onPressed: () {
                    Get.toNamed("/expense");
                  }, icon: Icon(Icons.upload)),
                  IconButton(onPressed: () {
                    Get.toNamed("/expense");
                  }, icon: Icon(Icons.download))
            ],));
          },

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      ),
    );
  }
}
