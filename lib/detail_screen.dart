import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/foodmodel.dart';
import 'package:flutter_nutrient_app/models/legacyfoodmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:provider/provider.dart';
import 'provider/nutrient_provider.dart';
import 'provider/portion_provider.dart';
import 'models/usernutrientmodel.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final TextEditingController amtController = TextEditingController();
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
    widget.amtController.text = '1.0';
    widget.amtController.addListener(_updateAmount);
    fetchData();
    super.initState();
  }

  void _updateAmount() {
    setState(() {
      widget.amtController.text;
    });
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

  String dropdownValue = "";
  double portionMult = 1.0;
  double amtMult = 1.0;
  bool initialSetup = true;

  @override
  Widget build(BuildContext context) {
    var nutrientState = context.watch<NutrientProvider>();
    var portionState = context.watch<PortionProvider>();
    List<List<dynamic>>? portions =
        portionState.getPortions(widget.id.toString());
    if (initialSetup) {
      if (portions!.isNotEmpty) {
        portionMult = double.parse(portions[0][7]) / 100.0;
      }
      dropdownValue = portions.isNotEmpty ? portions[0][6] : "";
      initialSetup = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: loading
            ? SizedBox.shrink()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  "${foodData.description}",
                  style: TextStyle(fontSize: 25),
                ),
              ),
      ),
      body: Container(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Text(
                    "Portion: per ${(widget.amtController.text.isEmpty ? 0 : double.parse(widget.amtController.text) * portionMult * 100).toStringAsFixed(3)}g",
                    style: TextStyle(fontSize: 25),
                  ),
                  TextFormField(
                    controller: widget.amtController,
                    keyboardType: TextInputType.number,
                  ),
                  dropdownValue != ""
                      ? DropdownButtonFormField<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: portions!
                              .map((e) => DropdownMenuItem<String>(
                                    value: e[6],
                                    child: Text(e[6]),
                                  ))
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                              for (var e in portions) {
                                if (e[6] == dropdownValue) {
                                  portionMult = double.parse(e[7]) / 100.0;
                                }
                              }
                            });
                          })
                      : Container(),
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
                                          : "${nutrient.name}:   ${(widget.amtController.text.isEmpty ? 0 : double.parse(widget.amtController.text) * foodData.foodNutrients![index].amount * portionMult).toStringAsFixed(3)} ${foodData.foodNutrients![index].amount == null ? "" : nutrient.unitName}",
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
                      List<UserNutrient> userNutrients = [];
                      for (int i = 0; i < foodData.foodNutrients!.length; i++) {
                        if (foodData.foodNutrients![i] != null) {
                          if (foodData.dataType == "SR Legacy" &&
                              foodData.foodNutrients![i]!.amount == null) {
                            continue;
                          }
                          userNutrients.add(UserNutrient(
                              name: foodData.foodNutrients![i].nutrient!.name,
                              amount: widget.amtController.text.isEmpty
                                  ? 0
                                  : double.parse(widget.amtController.text) *
                                      foodData.foodNutrients![i]!.amount *
                                      portionMult,
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
