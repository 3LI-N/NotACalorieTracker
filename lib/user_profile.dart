import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/nutrient_provider.dart';
import '/models/usernutrientmodel.dart';
import 'dailyvaluelist.dart';

import 'detail_screen.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var nutrientDVList = NutrientDVList(
      displayName: '', usdaName: '', dailyValue: 0, unitName: '');
  List<NutrientDVList> _nutrientDVList = [];

  @override
  void initState() {
    _nutrientDVList = nutrientDVList.nutrientDVList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var nutrientState = context.watch<NutrientProvider>();
    var userNutrients = nutrientState.getUserData
        .nutrientList; // map with string as key and UserNutrient as value
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Data",
          style: TextStyle(fontSize: 28),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: _nutrientDVList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.black,
                  ))
                : Expanded(
                    child: ListView.builder(
                        itemCount:
                            _nutrientDVList.length, // was userNutrients.length
                        itemBuilder: (context, index) {
                          //String key = userNutrients.keys.elementAt(index);
                          //UserNutrient nutrient = userNutrients[key];
                          NutrientDVList nutrient = _nutrientDVList[index];
                          double percentDV = 0.0;
                          if (userNutrients.containsKey(nutrient.usdaName) &&
                              userNutrients[nutrient.usdaName] != null) {
                            percentDV =
                                userNutrients[nutrient.usdaName].amount *
                                    100 /
                                    nutrient.dailyValue;
                          }
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
                                    "${nutrient.displayName}:   ${percentDV.toStringAsFixed(3)}% daily value",
                                    style: TextStyle(
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
        ],
      ),
    );
  }
}
