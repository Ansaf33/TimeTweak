import 'package:flutter/material.dart';
import 'package:time_tweak/app_data.dart';
import 'package:intl/intl.dart';
import 'package:time_tweak/main.dart';
import 'package:time_tweak/widgets/hamburger_menu.dart';

class MainSchedule extends StatelessWidget {
  const MainSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: theme.onSurface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: sw * 0.03,
                right: sw * 0.05,
                bottom: sh * 0.03,
                top: sh * 0.005,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: sw * 0.05),
                    child: IconButton(
                      onPressed: () => CustomDrawer.showMiniDrawer(context),
                      icon: Icon(
                        Icons.menu_rounded,
                        color: theme.surface,
                        size: sw * 0.1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: sw * 0.05, top: sw * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: sw * 0.015),
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontFamily: 'Loranthus',
                            fontSize: sw * 0.05,
                            color: theme.surface,
                          ),
                        ),
                        SizedBox(height: sh * 0.01),
                        Text(
                          ProfileData.name,
                          style: TextStyle(
                            fontFamily: 'Loranthus',
                            fontSize: sw * 0.07,
                            color: theme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: sw * 0.23, top: sw * 0.1),
                    child: ValueListenableBuilder(
                      valueListenable: themeCtrl,
                      builder:
                          (context, value, _) => IconButton(
                            onPressed: () {
                              if (themeCtrl.value == ThemeMode.dark) {
                                themeCtrl.value = ThemeMode.light;
                              } else {
                                themeCtrl.value = ThemeMode.dark;
                              }
                            },
                            icon: Icon(
                              (value == ThemeMode.dark)
                                  ? Icons.light_mode_outlined
                                  : Icons.dark_mode_outlined,
                              color: theme.surface,
                              size: sw * 0.1,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: sw,
                decoration: BoxDecoration(
                  color: theme.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: DefaultTabController(
                  initialIndex: _getTabIndex(),
                  length: 5,
                  child: Column(
                    children: [
                      SizedBox(height: sh * 0.02),
                      TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 5,
                        padding: EdgeInsets.only(bottom: sw * 0.03),
                        tabs: List.generate(
                          5,
                          (index) =>
                              _buildTab(context, _getTargetMonday(), index),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: List.generate(
                            5,
                            (index) =>
                                _buildPage(context, _getTargetMonday(), index),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, DateTime startDate, int i) {
    final date = startDate.add(Duration(days: i));
    return Tab(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(date.day.toString()),
          const SizedBox(height: 4),
          Text(DateFormat('E').format(date).toUpperCase()),
        ],
      ),
    );
  }

  int _getTabIndex() {
    final weekday = DateTime.now().weekday;
    return (weekday < 6) ? weekday - 1 : 0;
  }

  DateTime _getTargetMonday() {
    final now = DateTime.now();
    final weekday = now.weekday; // Monday = 1, Sunday = 7

    if (weekday >= 6) {
      // Weekend: Move to next Monday
      return now.add(Duration(days: 8 - weekday));
    } else {
      // Weekday: Move back to current Monday
      return now.subtract(Duration(days: weekday - 1));
    }
  }

  Widget _buildPage(BuildContext context, DateTime startDate, int i) {
    final date = startDate.add(Duration(days: i));
    return Placeholder();
  }
}
