import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiver/time.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'month_config.dart';

class WeekdaysView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var config = MonthViewConfig.of(context);
    var weekdays = <String>[];

    if (config.lang == 'en') {
      weekdays = config.shortLabels
          ? ["S", "M", "T", "W", "T", "F", "S"]
          : ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
    } else if (config.lang == 'ru') {
      weekdays = config.shortLabels
          ? ["П", "В", "С", "Ч", "П", "С", "В"]
          : ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"];
    } else if (config.lang == 'zh') {
      weekdays = ["日", "一", "二", "三", "四", "五", "六"];
    }

    Color textColor = config.sharing ? Colors.black : Theme.of(context).textTheme.titleLarge.color;

    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: weekdays
            .map<Widget>((d) => SizedBox(
                width: config.cellWidth,
                height: 30,
                child: AutoSizeText(d.toUpperCase(),
                    maxLines: 1,
                    minFontSize: 5,
                    textAlign: TextAlign.center,
                    style: config.shortLabels
                        ? Theme.of(context).textTheme.titleLarge.copyWith(color: textColor)
                        : Theme.of(context)
                            .textTheme
                            .labelMedium
                            .copyWith(color: Theme.of(context).secondaryHeaderColor))))
            .toList());
  }
}

typedef MonthCellCallback = Widget Function(DateTime date);

class MonthView extends StatefulWidget {
  final DateTime date;
  final MonthCellCallback cellBuilder;

  const MonthView(this.date, {this.cellBuilder});

  @override
  MonthViewState createState() => MonthViewState();
}

class MonthViewState extends State<MonthView> {
  DateTime get date => widget.date;
  MonthCellCallback get cellBuilder => widget.cellBuilder;

  @override
  Widget build(BuildContext context) {
    final config = MonthViewConfig.of(context);

    final firstDayOfWeek = DateFormat.EEEE(config.lang).dateSymbols.FIRSTDAYOFWEEK + 1;

    final monthStart = DateTime(date.year, date.month, 1);
    final startGap = (monthStart.weekday < firstDayOfWeek)
        ? 7 - (firstDayOfWeek - monthStart.weekday)
        : monthStart.weekday - firstDayOfWeek;

    final totalDays = daysInMonth(date.year, date.month);

    return Wrap(
        children: List<Widget>.generate(
                startGap, (_) => SizedBox(width: config.cellWidth, height: config.cellHeight)) +
            List<Widget>.generate(
                totalDays, (i) => cellBuilder(DateTime(date.year, date.month, i + 1))));
  }
}
