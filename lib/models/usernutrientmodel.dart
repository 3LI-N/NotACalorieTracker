import 'dart:convert';
import 'foodmodel.dart';

// UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

// String userDataToJson(UserData data) => json.encode(data.toJson());

// https://api.nal.usda.gov/fdc/v1/food/2344737?api_key=zTgpozOyBARqHpM9aPyhgJJCzPQuCTMXvjqUMxbR

class UserNutrient {
  UserNutrient({
    required this.name,
    required this.amount,
    required this.unitName,
  });

  String name;
  double amount;
  String unitName;
}


class UserData {
  UserData({
    required this.nutrientList,
  });

    Map nutrientList;
}