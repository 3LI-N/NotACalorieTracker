import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/foodmodel.dart';
import 'package:flutter_nutrient_app/models/legacyfoodmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:provider/provider.dart';
import 'provider/nutrient_provider.dart';
import 'models/usernutrientmodel.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  DetailScreen(this.id);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  //late FoodData foodData;
  late dynamic foodData;
  bool loading = true;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    var url = Uri.parse(
        "https://api.nal.usda.gov/fdc/v1/food/${widget.id}?api_key=zTgpozOyBARqHpM9aPyhgJJCzPQuCTMXvjqUMxbR");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedResponse = convert.jsonDecode(response.body);
      print('===================$decodedResponse');
      if (decodedResponse["dataType"] == "Survey (FNDDS)") {
        foodData = FoodData.fromJson(decodedResponse);
      } else if (decodedResponse["dataType"] == "SR Legacy") {
        foodData = LegacyFoodData.fromJson(decodedResponse);
      }
      print('===================$foodData');
      setState(() {
        loading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    var nutrientState = context.watch<NutrientProvider>();

    return Scaffold(
      appBar: AppBar(
        title: loading
            ? SizedBox.shrink()
            : FittedBox(
                child: Text(
                  "${foodData.description}",
                  style: TextStyle(fontSize: 28),
                ),
              ),
      ),
      body: Container(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Text(
                    "Portion: per 100g",
                    style: TextStyle(fontSize: 25),
                  ),
                  Container(
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: foodData == null
                              ? 0
                              : foodData.foodNutrients!.length,
                          itemBuilder: (context, index) {
                            var nutrient =
                                foodData.foodNutrients![index].nutrient!;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    alignment: Alignment.topLeft,
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      foodData.foodNutrients![index].amount ==
                                              null
                                          ? " ${nutrient.name}: "
                                          : "${nutrient.name}:   ${foodData.foodNutrients![index].amount} ${foodData.foodNutrients![index].amount == null ? "" : nutrient.unitName}",
                                      style: foodData.foodNutrients![index]
                                                  .amount ==
                                              null
                                          ? TextStyle(
                                              backgroundColor: Colors.green,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 23,
                                            )
                                          : TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.black54,
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      /*List<UserNutrient> userNutrients = List.generate(
                          foodData.foodNutrients!.length,
                          (index) => UserNutrient(
                              name:
                                  foodData.foodNutrients![index].nutrient!.name,
                              amount: foodData.dataType == "SR Legacy"
                                  ? foodData.foodNutrients![index]!.amount
                                  : foodData
                                      .foodNutrients![index].nutrient!.amount,
                              unitName: foodData
                                  .foodNutrients![index].nutrient!.unitName));*/
                      List<UserNutrient> userNutrients = [];
                      for (int i = 0; i < foodData.foodNutrients!.length; i++) {
                        if (foodData.foodNutrients![i] != null) {
                          if (foodData.dataType == "SR Legacy" &&
                              foodData.foodNutrients![i]!.amount == null) {
                            continue;
                          }

                          userNutrients.add(UserNutrient(
                              name: foodData.foodNutrients![i].nutrient!.name,
                              amount: foodData.foodNutrients![i]!.amount,
                              unitName: foodData
                                  .foodNutrients![i].nutrient!.unitName));
                        }
                      }
                      nutrientState.addFood(userNutrients);
                    },
                    child: Text('Add Food'),
                  ),
                ],
              ),
      ),
    );
  }
}
