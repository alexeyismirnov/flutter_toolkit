import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'app_theme.dart';

class AnimatedTab {
  final Widget icon;
  final String title;
  final Widget content;

  AnimatedTab({this.icon, this.title, this.content});
}

class _AnimatedTabView {
  final AnimatedTab tab;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;

  _AnimatedTabView({
    this.tab,
    TickerProvider vsync,
  })  : item = BottomNavigationBarItem(
          icon: tab.icon,
          label: tab.title.tr(),
        ),
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  FadeTransition transition(BuildContext context) {
    return FadeTransition(
      key: ValueKey(tab.title),
      opacity: _animation,
      child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.02), // Slightly down.
            end: Offset.zero,
          ).animate(_animation),
          child: tab.content),
    );
  }
}

class ContainerPage extends StatefulWidget {
  final List<AnimatedTab> tabs;
  final int highlight;
  ContainerPage({this.tabs, this.highlight = -1});

  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<_AnimatedTabView> _navigationViews;
  List<FadeTransition> transitions = [];

  @override
  void initState() {
    super.initState();

    _navigationViews =
        widget.tabs.map((t) => _AnimatedTabView(tab: t, vsync: this)).toList();

    for (_AnimatedTabView view in _navigationViews)
      view.controller.addListener(() => setState(() {}));

    _navigationViews[_currentIndex].controller.value = 1.0;

    for (_AnimatedTabView view in _navigationViews)
      transitions.add(view.transition(context));
  }

  @override
  void dispose() {
    for (_AnimatedTabView view in _navigationViews) view.controller.dispose();
    super.dispose();
  }

  Widget _buildTransitionsStack() {
    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return Stack(children: transitions);
  }

  void update(int index) => setState(() {
        _navigationViews[_currentIndex].controller.reverse();
        _currentIndex = index;
        _navigationViews[_currentIndex].controller.forward();
      });

  @override
  Widget build(BuildContext context) {
    final botNavBar = Container(
        color: Colors.transparent,
        child: widget.highlight == -1
            ? BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                backgroundColor: Colors.transparent,
                currentIndex: _currentIndex,
                items: _navigationViews
                    .map((navigationView) => navigationView.item)
                    .toList(),
                onTap: update)
            : BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.red,
                currentIndex: widget.highlight,
                elevation: 0,
                backgroundColor: Colors.transparent,
                items: _navigationViews
                    .map((navigationView) => navigationView.item)
                    .toList(),
                onTap: update));

    return Container(
      decoration: AppTheme.bg_decor_2() ??
          BoxDecoration(color: Theme.of(context).canvasColor),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(child: _buildTransitionsStack()),
          bottomNavigationBar: botNavBar),
    );
  }
}
