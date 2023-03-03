import 'package:flutter/material.dart';

class NutrientProvider extends ChangeNotifier {
  double _waterAmt = 0;

  double get getWaterAmt {
    return _waterAmt;
  }

  void addWater(double nutrientWater) {
    _waterAmt += nutrientWater;
    notifyListeners();
  }
}