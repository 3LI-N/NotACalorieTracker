import 'package:flutter/material.dart';
import 'package:flutter_nutrient_app/user_profile.dart';
import '/foodlist.dart';
import 'package:csv/csv.dart';
import 'provider/portion_provider.dart';
import 'package:provider/provider.dart';

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<List<dynamic>>? foodData;
  List<List<dynamic>> foodPortions = [];
  var foodList = FoodList(
    name: '',
    foodCategory: '',
    id: 0,
  );
  List<FoodList> _foodList = [];
  @override
  void initState() {
    _foodList = foodList.foodList();
    loadAssets();
    super.initState();
  }

  String searchString = "";

  @override
  Widget build(BuildContext context) {
    var portionState = context.watch<PortionProvider>();
    if (foodPortions.isNotEmpty) {
      portionState.setPortions(foodPortions);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Food Nutrients",
          style: TextStyle(fontSize: 28),
        ),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                value: 1,
                // row with 2 children
                child: Row(
                  children: [
                    Icon(Icons.star),
                    SizedBox(
                      width: 10,
                    ),
                    Text("User Data")
                  ],
                ),
              ),
            ],
            offset: Offset(0, 100),
            color: Colors.grey,
            elevation: 2,
            // on selected we show the dialog box
            onSelected: (value) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
          ),
          SizedBox(height: 10),
          foodData == null
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.black,
                ))
              : Expanded(
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: foodData!.length,
                      itemBuilder: (context, index) {
                        return index > 0 &&
                                foodData![index][2]
                                    .toLowerCase()
                                    .contains(searchString)
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            int.parse(foodData![index][0]))),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${foodData![index][2]}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54),
                                      ),
                                      /*Text(
                                      "${_foodList[index].foodCategory}",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black38),
                                    ),*/
                                    ],
                                  ),
                                ),
                              )
                            : Container();
                      }),
                ),
        ],
      ),
    );
  }

  loadAssets() async {
    var foodCsvData = await DefaultAssetBundle.of(context).loadString(
      "assets/food.csv",
    );
    List<List<dynamic>> foodCsvTable =
        const CsvToListConverter().convert(foodCsvData);
    var portionCsvData = await DefaultAssetBundle.of(context).loadString(
      "assets/food_portion.csv",
    );
    List<List<dynamic>> portionCsvTable =
        const CsvToListConverter().convert(portionCsvData);
    setState(() {
      foodData = foodCsvTable;
      foodPortions = portionCsvTable;
    });
  }
}
