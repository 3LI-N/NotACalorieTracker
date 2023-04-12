import 'package:flutter/material.dart';

class PortionProvider extends ChangeNotifier {
  List<List<dynamic>>? _portionData;

  List<List<dynamic>>? getPortions(String fdcID) {
    List<List<dynamic>>? result =
        _portionData?.where((e) => e[1] == fdcID).toList();
    List<List<dynamic>>? noDuplicates = [];
    if (result != null) {
      List<String> modifiers = [];
      for (var e in result) {
        if (!modifiers.contains(e[6])) {
          modifiers.add(e[6]);
          noDuplicates.add(e);
        }
      }
    }
    return noDuplicates;
  }

  void setPortions(List<List<dynamic>> foodPortions) {
    _portionData = foodPortions;
    //notifyListeners();
  }
}
