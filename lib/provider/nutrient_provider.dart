//import 'dart:js_util';

import 'package:flutter/material.dart';
//import 'package:flutter_nutrient_app/models/foodmodel.dart';
import '../models/usernutrientmodel.dart';

var initialData = new Map();

class NutrientProvider extends ChangeNotifier {
  UserData _ud = UserData(nutrientList: initialData);

  UserData get getUserData {
    return _ud;
  }

  void addFood(List<UserNutrient> addedFood) {
    for(var i = 0; i < addedFood.length; i++) {
      if(_ud.nutrientList.containsKey(addedFood[i].name)){
        _ud.nutrientList[addedFood[i].name].amount += addedFood[i].amount;
      } else {
        _ud.nutrientList[addedFood[i].name] = UserNutrient(name: addedFood[i].name, amount: addedFood[i].amount, unitName: addedFood[i].unitName);
      }
    }
    notifyListeners();
  }
}