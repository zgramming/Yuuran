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
}

final sharedFunction = SharedFunction.instance;
