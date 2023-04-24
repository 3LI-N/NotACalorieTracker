import 'package:flutter/material.dart';
import 'package:flutter_nutrient_app/user_profile.dart';
import 'package:provider/provider.dart';
import 'provider/nutrient_provider.dart';
import '/models/usernutrientmodel.dart';
import 'dailyvaluelist.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'detail_screen.dart';

String plan = "Default";

class UserVisualisation extends StatefulWidget {
  const UserVisualisation({Key? key}) : super(key: key);

  @override
  _UserVisualisationState createState() => _UserVisualisationState();
}

class _UserVisualisationState extends State<UserVisualisation> {
  var nutrientDVList = NutrientDVList(
      displayName: '', usdaName: '', dailyValue: 0, unitName: '');
  List<NutrientDVList> _nutrientDVList = [];

  @override
  void initState() {
    plan = "Default";
    _nutrientDVList = nutrientDVList.nutrientDVList(plan);
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
      body: Column(children: [
        DropdownButtonFormField<String>(
          value: plan,
          items: <String>[
            'Default',
            'Brain',
            'Heart',
            'Blood Pressure',
            'Energy',
            'Metabolism',
            'Immune System',
            'Libido',
            'Erectile Dysfunction'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              plan = newValue.toString();
              print(plan);
              _nutrientDVList = nutrientDVList.nutrientDVList(plan);
            });
          },
        ),
        SizedBox(height: 30),
        Expanded(
          child: GridView.builder(
              itemCount: _nutrientDVList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                //String key = userNutrients.keys.elementAt(index);
                //UserNutrient nutrient = userNutrients[key];
                NutrientDVList nutrient = _nutrientDVList[index];
                double percentDV = 0.0;
                bool overreccomendation = false;
                if (userNutrients.containsKey(nutrient.usdaName) &&
                    userNutrients[nutrient.usdaName] != null) {
                  percentDV = userNutrients[nutrient.usdaName].amount *
                      100 /
                      nutrient.dailyValue;
                  if ((percentDV / 100) > 1.0) {
                    percentDV = 100;
                    overreccomendation = true;
                  }
                }
                return Wrap(
                  spacing: 10.0, // gap between adjacent chips
                  runSpacing: 8.0, // gap between lines
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 4.0,
                      animation: true,
                      percent: percentDV / 100,
                      center: Text("${nutrient.displayName}"),
                      //center: Text("${percentDV.toStringAsFixed(3)}"),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.green,
                      footer: overreccomendation
                          ? Text(
                              "Over Recommended Daily Intake!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 17.0),
                            )
                          : Text(''),
                    ),
                    //maybe add numbers and units
                    userNutrients.containsKey(nutrient.usdaName)
                        ? Text(userNutrients[nutrient.usdaName]
                            .amount
                            .round()
                            .toString())
                        : Text("0"),
                    Text("/"),
                    Text(nutrient.dailyValue.round().toString()),
                    // Text(userNutrients[nutrient.usdaName].unitName().toString())
                  ],
                );
              }),
        ),
      ]),
    );
  }
}
