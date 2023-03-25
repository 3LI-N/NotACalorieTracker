import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/nutrient_provider.dart';
import '/models/usernutrientmodel.dart';

import 'detail_screen.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>{
  @override
  Widget build(BuildContext context) {
    var nutrientState = context.watch<NutrientProvider>();
    var userNutrients = nutrientState.getUserData.nutrientList; // map with string as key and UserNutrient as value
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
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: userNutrients.length,
                          itemBuilder: (context, index) {
                            String key = userNutrients.keys.elementAt(index);
                            UserNutrient nutrient = userNutrients[key];
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
                                      "${nutrient.name}:   ${nutrient.amount} ${nutrient.unitName}",
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