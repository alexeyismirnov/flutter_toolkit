import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectorDialog extends StatelessWidget {
  final String title;
  final List<Widget> content;

  SelectorDialog({this.title, this.content});

  @override
  Widget build(BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.all(5.0),
      content: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(title.tr().toUpperCase(),
                                  style: Theme.of(context).textTheme.button)
                            ])),
                  ] +
                  content)));
}
