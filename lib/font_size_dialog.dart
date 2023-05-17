import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'config_param.dart';

class FontSizeDialog extends StatefulWidget {
  @override
  FontSizeDialogState createState() => FontSizeDialogState();
}

class FontSizeDialogState extends State<FontSizeDialog> {
  double fontSize = ConfigParam.fontSize.val();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: const EdgeInsets.all(0.0),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('font_size'.tr(), style: Theme.of(context).textTheme.titleLarge)
                        ])),
                Slider(
                  value: fontSize,
                  min: 18.0,
                  max: 26.0,
                  divisions: 8,
                  label: '${fontSize.round()}',
                  onChanged: (double value) {
                    setState(() => fontSize = value);
                  },
                ),
              ]),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade300, padding: const EdgeInsets.all(10.0)),
            child: Text('ОК',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black)),
            onPressed: () {
              ConfigParam.fontSize.set(fontSize);
              Navigator.of(context).pop(null);
            },
          )
        ]);
  }
}
