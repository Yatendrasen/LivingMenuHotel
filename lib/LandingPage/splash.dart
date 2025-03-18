import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_menu_hotel/BookingScreens/bookingDateTimeScreen.dart';

import '../Constants/animatedRoute.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>{


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      // Navigator.pushAndRemoveUntil(context, AnimatedRoute.createRouteRightToLeft(BottomTab()), (route) => false);
      // if(isLogin){
        Navigator.pushAndRemoveUntil(
            context, AnimatedRoute.createRouteRightToLeft(BookingDateTimeScreen()), (
            route) => false);
     /* }else {
        Navigator.pushAndRemoveUntil(
            context, AnimatedRoute.createRouteRightToLeft(Login()), (
            route) => false);
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }

}
