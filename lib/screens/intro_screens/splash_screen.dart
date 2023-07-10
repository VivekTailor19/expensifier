import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Color(0xffA97FFA),
        body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset("assets/images/splash/logo.png",height: 80.w,width: 80.w,fit: BoxFit.fill,),
            SizedBox(height: 6.h,width:6.h,child: CircularProgressIndicator(backgroundColor: Color(0xFFFFE6EA),color:Color(0xFF9464FF),))
          ],
        ),),
      ),
    );
  }
}
