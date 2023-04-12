// To parse this JSON data, do
//
//     final legacyFoodData = legacyFoodDataFromJson(jsonString);

import 'dart:convert';

LegacyFoodData legacyFoodDataFromJson(String str) =>
    LegacyFoodData.fromJson(json.decode(str));

String legacyFoodDataToJson(LegacyFoodData data) => json.encode(data.toJson());

class LegacyFoodData {
  LegacyFoodData({
    required this.fdcId,
    required this.description,
    required this.publicationDate,
    required this.foodNutrients,
    required this.foodPortions,
    required this.dataType,
    required this.foodClass,
    required this.foodComponents,
    required this.foodAttributes,
    required this.nutrientConversionFactors,
    required this.inputFoods,
    required this.ndbNumber,
    required this.isHistoricalReference,
    required this.foodCategory,
  });

  int fdcId;
  String description;
  String publicationDate;
  List<FoodNutrient> foodNutrients;
  List<FoodPortion> foodPortions;
  String dataType;
  String foodClass;
  List<dynamic> foodComponents;
  List<dynamic> foodAttributes;
  List<dynamic> nutrientConversionFactors;
  List<dynamic> inputFoods;
  int ndbNumber;
  bool isHistoricalReference;
  Food foodCategory;

  factory LegacyFoodData.fromJson(Map<String, dynamic> json) => LegacyFoodData(
        fdcId: json["fdcId"],
        description: json["description"],
        publicationDate: json["publicationDate"],
        foodNutrients: List<FoodNutrient>.from(
            json["foodNutrients"].map((x) => FoodNutrient.fromJson(x))),
        foodPortions: json["foodPortions"] == null
            ? []
            : List<FoodPortion>.from(
                json["foodPortions"].map((x) => FoodPortion.fromJson(x))),
        dataType: json["dataType"],
        foodClass: json["foodClass"],
        foodComponents:
            List<dynamic>.from(json["foodComponents"].map((x) => x)),
        foodAttributes:
            List<dynamic>.from(json["foodAttributes"].map((x) => x)),
        nutrientConversionFactors:
            List<dynamic>.from(json["nutrientConversionFactors"].map((x) => x)),
        inputFoods: List<dynamic>.from(json["inputFoods"].map((x) => x)),
        ndbNumber: json["ndbNumber"],
        isHistoricalReference: json["isHistoricalReference"],
        foodCategory: Food.fromJson(json["foodCategory"]),
      );

  Map<String, dynamic> toJson() => {
        "fdcId": fdcId,
        "description": description,
        "publicationDate": publicationDate,
        "foodNutrients":
            List<dynamic>.from(foodNutrients.map((x) => x.toJson())),
        "foodPortions": List<dynamic>.from(foodPortions.map((x) => x.toJson())),
        "dataType": dataType,
        "foodClass": foodClass,
        "foodComponents": List<dynamic>.from(foodComponents.map((x) => x)),
        "foodAttributes": List<dynamic>.from(foodAttributes.map((x) => x)),
        "nutrientConversionFactors":
            List<dynamic>.from(nutrientConversionFactors.map((x) => x)),
        "inputFoods": List<dynamic>.from(inputFoods.map((x) => x)),
        "ndbNumber": ndbNumber,
        "isHistoricalReference": isHistoricalReference,
        "foodCategory": foodCategory.toJson(),
      };
}

class Food {
  Food({
    required this.id,
    required this.code,
    required this.description,
    this.foodNutrientSource,
  });

  int id;
  String code;
  String description;
  Food? foodNutrientSource;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        code: json["code"],
        description: json["description"],
        foodNutrientSource: json["foodNutrientSource"] == null
            ? null
            : Food.fromJson(json["foodNutrientSource"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "description": description,
        "foodNutrientSource": foodNutrientSource?.toJson(),
      };
}

class FoodNutrient {
  FoodNutrient({
    required this.nutrient,
    required this.type,
    this.id,
    this.amount,
    this.dataPoints,
    this.foodNutrientDerivation,
  });

  Nutrient nutrient;
  Type type;
  int? id;
  double? amount;
  int? dataPoints;
  Food? foodNutrientDerivation;

  factory FoodNutrient.fromJson(Map<String, dynamic> json) => FoodNutrient(
        nutrient: Nutrient.fromJson(json["nutrient"]),
        type: typeValues.map[json["type"]]!,
        id: json["id"],
        amount: json["amount"]?.toDouble(),
        dataPoints: json["dataPoints"],
        foodNutrientDerivation: json["foodNutrientDerivation"] == null
            ? null
            : Food.fromJson(json["foodNutrientDerivation"]),
      );

  Map<String, dynamic> toJson() => {
        "nutrient": nutrient.toJson(),
        "type": typeValues.reverse[type],
        "id": id,
        "amount": amount,
        "dataPoints": dataPoints,
        "foodNutrientDerivation": foodNutrientDerivation?.toJson(),
      };
}

class Nutrient {
  Nutrient({
    required this.id,
    required this.number,
    required this.name,
    required this.rank,
    required this.unitName,
  });

  int id;
  String number;
  String name;
  int rank;
  String unitName;

  factory Nutrient.fromJson(Map<String, dynamic> json) => Nutrient(
        id: json["id"],
        number: json["number"],
        name: json["name"],
        rank: json["rank"],
        unitName: json["unitName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "name": name,
        "rank": rank,
        "unitName": unitName,
      };
}

enum UnitName { G, KCAL, K_J, MG, UNIT_NAME_G, IU }

final unitNameValues = EnumValues({
  "g": UnitName.G,
  "IU": UnitName.IU,
  "kcal": UnitName.KCAL,
  "kJ": UnitName.K_J,
  "mg": UnitName.MG,
  "µg": UnitName.UNIT_NAME_G
});

enum Type { FOOD_NUTRIENT }

final typeValues = EnumValues({"FoodNutrient": Type.FOOD_NUTRIENT});

class FoodPortion {
  FoodPortion({
    required this.id,
    required this.gramWeight,
    required this.sequenceNumber,
    required this.amount,
    required this.modifier,
    required this.measureUnit,
  });

  int id;
  double gramWeight;
  int sequenceNumber;
  double amount;
  String modifier;
  MeasureUnit measureUnit;

  factory FoodPortion.fromJson(Map<String, dynamic> json) => FoodPortion(
        id: json["id"],
        gramWeight: json["gramWeight"]?.toDouble(),
        sequenceNumber: json["sequenceNumber"],
        amount: json["amount"],
        modifier: json["modifier"],
        measureUnit: MeasureUnit.fromJson(json["measureUnit"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gramWeight": gramWeight,
        "sequenceNumber": sequenceNumber,
        "amount": amount,
        "modifier": modifier,
        "measureUnit": measureUnit.toJson(),
      };
}

class MeasureUnit {
  MeasureUnit({
    required this.id,
    required this.name,
    required this.abbreviation,
  });

  int id;
  String name;
  String abbreviation;

  factory MeasureUnit.fromJson(Map<String, dynamic> json) => MeasureUnit(
        id: json["id"],
        name: json["name"],
        abbreviation: json["abbreviation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "abbreviation": abbreviation,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
