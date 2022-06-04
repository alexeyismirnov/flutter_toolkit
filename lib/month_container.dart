import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import 'month_view.dart';
import 'month_config.dart';
import 'extensions.dart';

class MonthContainer extends StatefulWidget {
  final DateTime initialDate;
  final MonthCellCallback cellBuilder;

  const MonthContainer(this.initialDate, {this.cellBuilder});

  @override
  _MonthContainerState createState() => _MonthContainerState();
}

class _MonthContainerState extends State<MonthContainer> {
  static const initialPage = 100000;
  PageController _controller;

  String title;

  @override
  void initState() {
    super.initState();

    _controller = PageController(initialPage: initialPage);
    updateTitle();
  }

  void updateTitle([int index = initialPage]) {
    final currentDate = Jiffy(widget.initialDate).add(months: index - initialPage);

    setState(() {
      title = currentDate.format("LLLL yyyy").capitalize();
    });
  }

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 10);
    final config = MonthViewConfig.of(context);

    return Container(
        width: config.containerWidth,
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title,
                  style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
              spacer,
              WeekdaysView(),
              spacer,
              SizedBox(
                  width: config.containerWidth,
                  height: config.cellWidth * 6,
                  child: PageView.builder(
                      key: const PageStorageKey("monthview"),
                      controller: _controller,
                      onPageChanged: (page) => updateTitle(page),
                      itemBuilder: (BuildContext context, int index) {
                        final currentDate =
                            Jiffy(widget.initialDate).add(months: index - initialPage).dateTime;

                        return Align(
                            alignment: Alignment.topCenter,
                            child: MonthView(currentDate, cellBuilder: widget.cellBuilder));
                      })),
            ]));
  }
}
