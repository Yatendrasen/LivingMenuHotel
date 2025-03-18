import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// circularIndicator() {
//   return const Center(
//     child: CircularProgressIndicator.adaptive(
//       backgroundColor: Colors.transparent,
//       strokeWidth: 3,
//     ),
//   );
// }

Center circularIndicator({bool color = false}){
  return  Center(
    child: SpinKitThreeBounce(
      color:color == false ? Colors.white : Color(0xFF001FFF),
      size: 16.0,
    ),
  );
}
circularIndicator1(){
  return Align(
    alignment: Alignment.centerRight,
    child: SpinKitThreeBounce(
      color:Color(0xFF001FFF),
      size: 16.0,
    ),
  );
}