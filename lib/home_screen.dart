import 'package:flutter/material.dart';
import 'package:flutter_nutrient_app/user_profile.dart';
import '/foodlist.dart';

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var foodList = FoodList(
    name: '',
    foodCategory: '',
    id: 0,
  );
  List<FoodList> _foodList = [];
  @override
  void initState() {
    _foodList = foodList.foodList();
    super.initState();
  }

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Search foods');
  String searchString = "";

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
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
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _foodList.length,
                itemBuilder: (context, index) {
                  return _foodList[index]
                          .name
                          .toLowerCase()
                          .contains(searchString)
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(_foodList[index].id)),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_foodList[index].name}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54),
                                ),
                                Text(
                                  "${_foodList[index].foodCategory}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black38),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container();
                }),
          ],
        ),
      ),
    );
  }
}
