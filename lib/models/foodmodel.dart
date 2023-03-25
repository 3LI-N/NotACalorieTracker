// To parse this JSON data, do
//
//     final foodData = foodDataFromJson(jsonString);

import 'dart:convert';

FoodData foodDataFromJson(String str) => FoodData.fromJson(json.decode(str));

String foodDataToJson(FoodData data) => json.encode(data.toJson());

class FoodData {
    FoodData({
        this.foodClass,
        this.description,
        this.foodNutrients,
        this.foodAttributes,
        this.foodCode,
        this.startDate,
        this.endDate,
        this.wweiaFoodCategory,
        this.dataType,
        this.fdcId,
        this.foodPortions,
        this.publicationDate,
        this.inputFoods,
    });

    String? foodClass;
    String? description;
    List<FoodNutrient>? foodNutrients;
    List<FoodAttribute>? foodAttributes;
    String? foodCode;
    String? startDate;
    String? endDate;
    WweiaFoodCategory? wweiaFoodCategory;
    String? dataType;
    int? fdcId;
    List<FoodPortion>? foodPortions;
    String? publicationDate;
    List<InputFood>? inputFoods;

    FoodData copyWith({
        String? foodClass,
        String? description,
        List<FoodNutrient>? foodNutrients,
        List<FoodAttribute>? foodAttributes,
        String? foodCode,
        String? startDate,
        String? endDate,
        WweiaFoodCategory? wweiaFoodCategory,
        String? dataType,
        int? fdcId,
        List<FoodPortion>? foodPortions,
        String? publicationDate,
        List<InputFood>? inputFoods,
    }) => 
        FoodData(
            foodClass: foodClass ?? this.foodClass,
            description: description ?? this.description,
            foodNutrients: foodNutrients ?? this.foodNutrients,
            foodAttributes: foodAttributes ?? this.foodAttributes,
            foodCode: foodCode ?? this.foodCode,
            startDate: startDate ?? this.startDate,
            endDate: endDate ?? this.endDate,
            wweiaFoodCategory: wweiaFoodCategory ?? this.wweiaFoodCategory,
            dataType: dataType ?? this.dataType,
            fdcId: fdcId ?? this.fdcId,
            foodPortions: foodPortions ?? this.foodPortions,
            publicationDate: publicationDate ?? this.publicationDate,
            inputFoods: inputFoods ?? this.inputFoods,
        );

    factory FoodData.fromJson(Map<String, dynamic> json) => FoodData(
        foodClass: json["foodClass"],
        description: json["description"],
        foodNutrients: List<FoodNutrient>.from(json["foodNutrients"].map((x) => FoodNutrient.fromJson(x))),
        foodAttributes: List<FoodAttribute>.from(json["foodAttributes"].map((x) => FoodAttribute.fromJson(x))),
        foodCode: json["foodCode"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        wweiaFoodCategory: WweiaFoodCategory.fromJson(json["wweiaFoodCategory"]),
        dataType: json["dataType"],
        fdcId: json["fdcId"],
        foodPortions: List<FoodPortion>.from(json["foodPortions"].map((x) => FoodPortion.fromJson(x))),
        publicationDate: json["publicationDate"],
        inputFoods: List<InputFood>.from(json["inputFoods"].map((x) => InputFood.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "foodClass": foodClass,
        "description": description,
        "foodNutrients": List<dynamic>.from(foodNutrients!.map((x) => x.toJson())),
        "foodAttributes": List<dynamic>.from(foodAttributes!.map((x) => x.toJson())),
        "foodCode": foodCode,
        "startDate": startDate,
        "endDate": endDate,
        "wweiaFoodCategory": wweiaFoodCategory?.toJson(),
        "dataType": dataType,
        "fdcId": fdcId,
        "foodPortions": List<dynamic>.from(foodPortions!.map((x) => x.toJson())),
        "publicationDate": publicationDate,
        "inputFoods": List<dynamic>.from(inputFoods!.map((x) => x.toJson())),
    };
}

class FoodAttribute {
    FoodAttribute({
        this.id,
        this.name,
        this.value,
        this.foodAttributeType,
        this.rank,
    });

    int? id;
    String? name;
    String? value;
    FoodAttributeType? foodAttributeType;
    int? rank;

    FoodAttribute copyWith({
        int? id,
        String? name,
        String? value,
        FoodAttributeType? foodAttributeType,
        int? rank,
    }) => 
        FoodAttribute(
            id: id ?? this.id,
            name: name ?? this.name,
            value: value ?? this.value,
            foodAttributeType: foodAttributeType ?? this.foodAttributeType,
            rank: rank ?? this.rank,
        );

    factory FoodAttribute.fromJson(Map<String, dynamic> json) => FoodAttribute(
        id: json["id"],
        name: json["name"],
        value: json["value"],
        foodAttributeType: FoodAttributeType.fromJson(json["foodAttributeType"]),
        rank: json["rank"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "value": value,
        "foodAttributeType": foodAttributeType?.toJson(),
        "rank": rank,
    };
}

class FoodAttributeType {
    FoodAttributeType({
        this.id,
        this.name,
        this.description,
    });

    int? id;
    String? name;
    String? description;

    FoodAttributeType copyWith({
        int? id,
        String? name,
        String? description,
    }) => 
        FoodAttributeType(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
        );

    factory FoodAttributeType.fromJson(Map<String, dynamic> json) => FoodAttributeType(
        id: json["id"],
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
    };
}

class FoodNutrient {
    FoodNutrient({
        this.type,
        this.id,
        this.nutrient,
        required this.amount,
    });

    Type? type;
    int? id;
    Nutrient? nutrient;
    double amount;

    FoodNutrient copyWith({
        Type? type,
        int? id,
        Nutrient? nutrient,
        required double amount,
    }) => 
        FoodNutrient(
            type: type ?? this.type,
            id: id ?? this.id,
            nutrient: nutrient ?? this.nutrient,
            amount: amount,
        );

    factory FoodNutrient.fromJson(Map<String, dynamic> json) => FoodNutrient(
        type: typeValues.map[json["type"]],
        id: json["id"],
        nutrient: Nutrient.fromJson(json["nutrient"]),
        amount: json["amount"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "id": id,
        "nutrient": nutrient?.toJson(),
        "amount": amount,
    };
}

class Nutrient {
    Nutrient({
        this.id,
        this.number,
        required this.name,
        this.rank,
        required this.unitName,
    });

    int? id;
    String? number;
    String name;
    int? rank;
    String unitName;

    Nutrient copyWith({
        int? id,
        String? number,
        String? name,
        int? rank,
        UnitName? unitName,
    }) => 
        Nutrient(
            id: id ?? this.id,
            number: number ?? this.number,
            name: name ?? this.name,
            rank: rank ?? this.rank,
            unitName: unitName as String? ?? this.unitName,
        );

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
        "unitName": unitNameValues.reverse[unitName],
    };
}

enum UnitName { G, KCAL, MG, UNIT_NAME_G, INIT }

final unitNameValues = EnumValues({
    "g": UnitName.G,
    "kcal": UnitName.KCAL,
    "mg": UnitName.MG,
    "µg": UnitName.UNIT_NAME_G,
    "": UnitName.INIT,
});

enum Type { FOOD_NUTRIENT }

final typeValues = EnumValues({
    "FoodNutrient": Type.FOOD_NUTRIENT
});

class FoodPortion {
    FoodPortion({
        this.id,
        this.measureUnit,
        this.modifier,
        this.gramWeight,
        this.sequenceNumber,
        this.portionDescription,
    });

    int? id;
    MeasureUnit? measureUnit;
    String? modifier;
    double? gramWeight;
    int? sequenceNumber;
    String? portionDescription;

    FoodPortion copyWith({
        int? id,
        MeasureUnit? measureUnit,
        String? modifier,
        double? gramWeight,
        int? sequenceNumber,
        String? portionDescription,
    }) => 
        FoodPortion(
            id: id ?? this.id,
            measureUnit: measureUnit ?? this.measureUnit,
            modifier: modifier ?? this.modifier,
            gramWeight: gramWeight ?? this.gramWeight,
            sequenceNumber: sequenceNumber ?? this.sequenceNumber,
            portionDescription: portionDescription ?? this.portionDescription,
        );

    factory FoodPortion.fromJson(Map<String, dynamic> json) => FoodPortion(
        id: json["id"],
        measureUnit: MeasureUnit.fromJson(json["measureUnit"]),
        modifier: json["modifier"],
        gramWeight: json["gramWeight"].toDouble(),
        sequenceNumber: json["sequenceNumber"],
        portionDescription: json["portionDescription"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "measureUnit": measureUnit?.toJson(),
        "modifier": modifier,
        "gramWeight": gramWeight,
        "sequenceNumber": sequenceNumber,
        "portionDescription": portionDescription,
    };
}

class MeasureUnit {
    MeasureUnit({
        this.id,
        this.name,
        this.abbreviation,
    });

    int? id;
    String? name;
    String? abbreviation;

    MeasureUnit copyWith({
        int? id,
        String? name,
        String? abbreviation,
    }) => 
        MeasureUnit(
            id: id ?? this.id,
            name: name ?? this.name,
            abbreviation: abbreviation ?? this.abbreviation,
        );

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

class InputFood {
    InputFood({
        this.id,
        this.unit,
        this.portionDescription,
        this.portionCode,
        this.foodDescription,
        this.sequenceNumber,
        this.ingredientDescription,
        this.ingredientWeight,
        this.ingredientCode,
        this.amount,
    });

    int? id;
    String? unit;
    String? portionDescription;
    String? portionCode;
    String? foodDescription;
    int? sequenceNumber;
    String? ingredientDescription;
    double? ingredientWeight;
    int? ingredientCode;
    double? amount;

    InputFood copyWith({
        int? id,
        String? unit,
        String? portionDescription,
        String? portionCode,
        String? foodDescription,
        int? sequenceNumber,
        String? ingredientDescription,
        double? ingredientWeight,
        int? ingredientCode,
        double? amount,
    }) => 
        InputFood(
            id: id ?? this.id,
            unit: unit ?? this.unit,
            portionDescription: portionDescription ?? this.portionDescription,
            portionCode: portionCode ?? this.portionCode,
            foodDescription: foodDescription ?? this.foodDescription,
            sequenceNumber: sequenceNumber ?? this.sequenceNumber,
            ingredientDescription: ingredientDescription ?? this.ingredientDescription,
            ingredientWeight: ingredientWeight ?? this.ingredientWeight,
            ingredientCode: ingredientCode ?? this.ingredientCode,
            amount: amount ?? this.amount,
        );

    factory InputFood.fromJson(Map<String, dynamic> json) => InputFood(
        id: json["id"],
        unit: json["unit"],
        portionDescription: json["portionDescription"],
        portionCode: json["portionCode"],
        foodDescription: json["foodDescription"],
        sequenceNumber: json["sequenceNumber"],
        ingredientDescription: json["ingredientDescription"],
        ingredientWeight: json["ingredientWeight"].toDouble(),
        ingredientCode: json["ingredientCode"],
        amount: json["amount"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "unit": unit,
        "portionDescription": portionDescription,
        "portionCode": portionCode,
        "foodDescription": foodDescription,
        "sequenceNumber": sequenceNumber,
        "ingredientDescription": ingredientDescription,
        "ingredientWeight": ingredientWeight,
        "ingredientCode": ingredientCode,
        "amount": amount,
    };
}

class WweiaFoodCategory {
    WweiaFoodCategory({
        this.wweiaFoodCategoryCode,
        this.wweiaFoodCategoryDescription,
    });

    int? wweiaFoodCategoryCode;
    String? wweiaFoodCategoryDescription;

    WweiaFoodCategory copyWith({
        int? wweiaFoodCategoryCode,
        String? wweiaFoodCategoryDescription,
    }) => 
        WweiaFoodCategory(
            wweiaFoodCategoryCode: wweiaFoodCategoryCode ?? this.wweiaFoodCategoryCode,
            wweiaFoodCategoryDescription: wweiaFoodCategoryDescription ?? this.wweiaFoodCategoryDescription,
        );

    factory WweiaFoodCategory.fromJson(Map<String, dynamic> json) => WweiaFoodCategory(
        wweiaFoodCategoryCode: json["wweiaFoodCategoryCode"],
        wweiaFoodCategoryDescription: json["wweiaFoodCategoryDescription"],
    );

    Map<String, dynamic> toJson() => {
        "wweiaFoodCategoryCode": wweiaFoodCategoryCode,
        "wweiaFoodCategoryDescription": wweiaFoodCategoryDescription,
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
