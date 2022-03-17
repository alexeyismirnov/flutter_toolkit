import 'package:flutter/material.dart';

extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but callback have index as second argument
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndexed(void Function(E e, int i) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }
}

extension ShowWidget on Widget {
  Future push(BuildContext context) => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => this,
      ));

  Future pushReplacement(BuildContext context) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => this,
      ));

  Future<T> show<T>(BuildContext context, {canDismiss = true}) =>
      showDialog<T>(barrierDismissible: canDismiss, context: context, builder: (_) => this);
}

extension Capitalize on String {
  String capitalize() => this[0].toUpperCase() + this.substring(1);
}

extension ScreenDimensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
