import 'dart:collection';

import 'package:flutter/material.dart';

class SharedFunction {
  SharedFunction._();
  static final instance = SharedFunction._();

  double vw(BuildContext context) => MediaQuery.of(context).size.width;
  double vh(BuildContext context) => MediaQuery.of(context).size.height;

  bool isLargeScreen(BuildContext context) => MediaQuery.of(context).size.width > 1200;
  bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800 && MediaQuery.of(context).size.width <= 1200;
  bool isSmallScreen(BuildContext context) => MediaQuery.of(context).size.width < 800;

  double _maxWidthWebsite(BuildContext context) => vw(context) / 1.5;
  double _minHeightWebsite(BuildContext context) => vh(context) / 1.5;

  BoxConstraints constraintWebsite(BuildContext context) => BoxConstraints(
        maxWidth: _maxWidthWebsite(context),
        minHeight: _minHeightWebsite(context),
      );

  String monthString(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '-';
    }
  }

  Map<String, List> groupByFirstCharacter(List<String> names) {
    var tempMap = <String, List>{};

    if (names.isEmpty) return tempMap;

    for (var name in names) {
      final isExists = tempMap[name[0]];
      if (isExists == null) {
        tempMap[name[0]] = [];
      }

      tempMap[name[0]]!.add(name);
    }

    final sortedByKey =
        SplayTreeMap<String, List>.from(tempMap, (key1, key2) => key1.compareTo(key2));

    return sortedByKey;
  }
}

final sharedFunction = SharedFunction.instance;
