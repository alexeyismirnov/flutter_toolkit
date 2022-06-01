import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SimpleCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;
  final bool vertical;

  const SimpleCard({this.title, this.image, this.onTap, this.vertical = false});

  @override
  Widget build(BuildContext context) {
    Widget content1, content2, content;

    if (vertical) {
      content1 = SizedBox(
        height: 150,
        child: Image.asset(
          "assets/images/$image",
          fit: BoxFit.contain,
        ),
      );

      content2 = Text(title.tr(),
          textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6);

      content = Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Center(child: content1),
        const SizedBox(height: 10),
        Row(mainAxisSize: MainAxisSize.max, children: [Expanded(child: content2)])
      ]);
    } else {
      content1 = SizedBox(
        width: 100,
        child: Image.asset(
          "assets/images/$image",
          fit: BoxFit.contain,
        ),
      );

      content2 =
          Text(title, style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.center);

      content = Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [content1, const SizedBox(width: 10), Expanded(child: content2)]);
    }

    return Card(
        elevation: 10.0,
        child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTap,
            child: Padding(padding: const EdgeInsets.all(10.0), child: content)));
  }
}

class CardWithTitle extends StatelessWidget {
  final String title;
  final Widget content;

  const CardWithTitle({Key key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
      elevation: 10.0,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: (title.isEmpty)
              ? content
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Row(children: [
                        Flexible(
                            fit: FlexFit.tight,
                            child: AutoSizeText(title.tr().toUpperCase(),
                                maxLines: 1,
                                minFontSize: 5,
                                style: Theme.of(context).textTheme.button)),
                      ])),
                  const Divider(color: Colors.black),
                  content
                ])));
}
