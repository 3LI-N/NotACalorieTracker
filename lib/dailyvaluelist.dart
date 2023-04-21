class NutrientDVList {
  final String displayName;
  final String usdaName;
  final double dailyValue;
  final String unitName;

  NutrientDVList({
    required this.displayName,
    required this.usdaName,
    required this.dailyValue,
    required this.unitName,
  });

  List<NutrientDVList> nutrientDVList() {
    //maybe add "plan" as argument to function later
    double calciumDV = 1300;
    double fiberDV = 28;
    double fatDV = 78;
    double magnesiumDV = 420;
    double manganeseDV = 2.3;
    double phosphorusDV = 1250;
    double potassiumDV = 4700;
    double vitaminCDV = 90;
    double vitaminDDV = 20;
    double vitaminKDV = 120;
    double copperDV = 0.9;
    double niacinDV = 16;
    double pantothenicAcidDV = 5;
    double riboflavinDV = 1.3;
    double seleniumDV = 55;
    double sodiumDV = 2300;
    double thiaminDV = 1.2;
    double carbohydrateDV = 275;
    double vitaminADV = 900;
    double vitaminB6DV = 1.7;
    double vitaminB12DV = 2.4;
    double vitaminEDV = 15;
    double zincDV = 11;
    double cholesterolDV = 300;
    double ironDV = 18;
    double proteinDV = 50;
    double saturatedFatDV = 20;
    double cholineDV = 550;
    String plan = "default";
    if (plan == "heart") {
      cholesterolDV = 300 * 0.8;
    } else if (plan == "blood pressure") {
      fatDV = 78 * 0.85;
      sodiumDV = 2300 * 0.8;
      carbohydrateDV = 275 * 0.9;
      cholesterolDV = 300 * 0.8;
      saturatedFatDV = 20 * 0.8;
    } else if (plan == "bulk") {
      fatDV = 78 * 1.1;
      carbohydrateDV = 275 * 1.2;
      proteinDV = 50 * 1.3;
    } else if (plan == "brain") {
      fatDV = 78 * 1.1;
      saturatedFatDV = 20 * 1.1;
      vitaminKDV *= 1.15;
      zincDV *= 1.15;
      magnesiumDV *= 1.15;
      copperDV *= 1.15;
      ironDV *= 1.15;
    } else if (plan == "Erectile Dysfunction") {
      vitaminDDV *= 1.2;
      fatDV *= 0.9;
      saturatedFatDV *= 0.9;
    } else if (plan == "sex drive") {
      magnesiumDV *= 1.1;
      ironDV *= 1.1;
      vitaminDDV *= 1.1;
      zincDV *= 1.1;
    } else if (plan == "energy") {
      pantothenicAcidDV *= 1.15;
      vitaminB6DV *= 1.15;
      vitaminB12DV *= 1.15;
      vitaminDDV *= 1.15;
    } else if (plan == "metabolism") {
      vitaminB12DV *= 1.15;
      vitaminB6DV *= 1.15;
      niacinDV *= 1.15;
      pantothenicAcidDV *= 1.15;
      riboflavinDV *= 1.15;
      thiaminDV *= 1.15;
      vitaminDDV *= 1.1;
      calciumDV *= 1.1;
      ironDV *= 1.1;
      magnesiumDV *= 1.1;
    } else if (plan == "immune system") {
      vitaminCDV *= 1.15;
      vitaminEDV *= 1.15;
      vitaminADV *= 1.15;
      vitaminDDV *= 1.15;
      ironDV *= 1.1;
      seleniumDV *= 1.1;
      zincDV *= 1.1;
    }

    return [
      NutrientDVList(
        displayName: "Calcium",
        usdaName: "Calcium, Ca",
        dailyValue: calciumDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Dietary Fiber",
        usdaName: "Fiber, total dietary",
        dailyValue: fiberDV,
        unitName: "g",
      ),
      NutrientDVList(
        displayName: "Fat",
        usdaName: "Total lipid (fat)",
        dailyValue: fatDV,
        unitName: "g",
      ),
      NutrientDVList(
        displayName: "Magnesium",
        usdaName: "Magnesium, Mg",
        dailyValue: magnesiumDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Manganese",
        usdaName: "Manganese, Mn",
        dailyValue: manganeseDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Phosphorus",
        usdaName: "Phosphorus, P",
        dailyValue: phosphorusDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Potassium",
        usdaName: "Potassium, K",
        dailyValue: potassiumDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Vitamin C",
        usdaName: "Vitamin C, total ascorbic acid",
        dailyValue: vitaminCDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Vitamin D",
        usdaName: "Vitamin D (D2 + D3)",
        dailyValue: vitaminDDV,
        unitName: "µg",
      ),
      NutrientDVList(
        displayName: "Vitamin K",
        usdaName: "Vitamin K (phylloquinone)",
        dailyValue: vitaminKDV,
        unitName: "µg",
      ),
      NutrientDVList(
        displayName: "Copper",
        usdaName: "Copper, Cu",
        dailyValue: copperDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Niacin",
        usdaName: "Niacin",
        dailyValue: niacinDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Pantothenic Acid",
        usdaName: "Pantothenic acid",
        dailyValue: pantothenicAcidDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Riboflavin",
        usdaName: "Riboflavin",
        dailyValue: riboflavinDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Selenium",
        usdaName: "Selenium, Se",
        dailyValue: seleniumDV,
        unitName: "µg",
      ),
      NutrientDVList(
        displayName: "Sodium",
        usdaName: "Sodium, Na",
        dailyValue: sodiumDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Thiamin",
        usdaName: "Thiamin",
        dailyValue: thiaminDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Carbohydrate",
        usdaName: "Carbohydrate, by difference",
        dailyValue: carbohydrateDV,
        unitName: "g",
      ),
      NutrientDVList(
        displayName: "Vitamin A",
        usdaName: "Vitamin A, RAE",
        dailyValue: vitaminADV,
        unitName: "µg",
      ),
      NutrientDVList(
        displayName: "Vitamin B-6",
        usdaName: "Vitamin B-6",
        dailyValue: vitaminB6DV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Vitamin B-12",
        usdaName: "Vitamin B-12",
        dailyValue: vitaminB12DV,
        unitName: "µg",
      ),
      NutrientDVList(
        displayName: "Vitamin E",
        usdaName: "Vitamin E (alpha-tocopherol)",
        dailyValue: vitaminEDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Zinc",
        usdaName: "Zinc, Zn",
        dailyValue: zincDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Cholesterol",
        usdaName: "Cholesterol",
        dailyValue: cholesterolDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Iron",
        usdaName: "Iron, Fe",
        dailyValue: ironDV,
        unitName: "mg",
      ),
      NutrientDVList(
        displayName: "Protein",
        usdaName: "Protein",
        dailyValue: proteinDV,
        unitName: "g",
      ),
      NutrientDVList(
        displayName: "Saturated fat",
        usdaName: "Fatty acids, total saturated",
        dailyValue: saturatedFatDV,
        unitName: "g",
      ),
      NutrientDVList(
        displayName: "Choline",
        usdaName: "Choline, total",
        dailyValue: cholineDV,
        unitName: "mg",
      ),
    ];
  }
}
