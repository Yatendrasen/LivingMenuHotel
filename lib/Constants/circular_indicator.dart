import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_spinkit/flutter_spinkit.dart';
circularIndicator() {
  return const Center(
    child: CircularProgressIndicator.adaptive(
      backgroundColor: Colors.transparent,
      strokeWidth: 3,
    ),
  );
}