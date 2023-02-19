import 'package:flutter/material.dart';

class ShimmerProvider extends ChangeNotifier{
  Future shimmerPkg() async {
    AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
    );
    notifyListeners();
  }
}