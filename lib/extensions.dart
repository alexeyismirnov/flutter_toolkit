import 'package:flutter/material.dart';

extension ShowWidget on Widget {
  Future push(BuildContext context) => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => this,
      ));

  Future pushReplacement(BuildContext context) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => this,
      ));

  Future<T?> show<T>(BuildContext context, {canDismiss = true}) =>
      showDialog<T>(barrierDismissible: canDismiss, context: context, builder: (_) => this);
}

extension Capitalize on String {
  String capitalize() => this[0].toUpperCase() + this.substring(1);
}

extension ScreenDimensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  bool get isTablet => screenWidth > 500;
}
