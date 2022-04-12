import 'package:flutter/material.dart';
import 'utils.dart';

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

  /// [Input Decoration] Section
  InputDecoration get myInputDecoration {
    final _outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: grey),
    );

    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: "Default Hint Text",
      hintStyle: bFont.copyWith(fontSize: 12.0, color: grey),
      enabledBorder: _outlineInputBorder,
      focusedBorder: _outlineInputBorder.copyWith(borderSide: const BorderSide(color: primary)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
    );

    return inputDecoration;
  }

  /// [String] Section
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
}

final sharedFunction = SharedFunction.instance;
