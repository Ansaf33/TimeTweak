import 'package:flutter/material.dart';
import 'package:time_tweak/app_data.dart';
import 'package:intl/intl.dart';
import 'package:time_tweak/main.dart';
import 'package:time_tweak/services_and_models/models.dart';
import 'package:time_tweak/services_and_models/utils.dart';
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
                  SizedBox(width: sw * 0.03),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: sw * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                            CurrentUserData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Loranthus',
                              fontSize: sw * 0.07,
                              color: theme.surface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: sw * 0.02, top: sw * 0.1),
                    child: ValueListenableBuilder(
                      valueListenable: themeCtrl,
                      builder:
                          (context, value, _) => IconButton(
                            onPressed: () {
                              themeCtrl.value =
                                  themeCtrl.value == ThemeMode.dark
                                      ? ThemeMode.light
                                      : ThemeMode.dark;
                            },
                            icon: Icon(
                              value == ThemeMode.dark
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
            ValueListenableBuilder(
              valueListenable: Rebuild.tt,
              builder:
                  (context, value, _) => Expanded(
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
                                (index) => _buildTab(
                                  context,
                                  _getTargetMonday(),
                                  index,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: List.generate(
                                  5,
                                  (index) => _buildPage(
                                    context,
                                    _getTargetMonday(),
                                    index,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
    final sw = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).colorScheme;
    final date = startDate.add(Duration(days: i));
    final formattedDate =
        "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
    final perDaytt =
        TimeTableData.tt
            .where(
              (c) =>
                  (c.date == formattedDate && c.batch == CurrentUserData.batch),
            )
            .toList();
    perDaytt.sort((a, b) => _getValue(a).compareTo(_getValue(b)));
    return ListView.builder(
      itemCount: perDaytt.length,
      itemBuilder: (context, index) {
        final entry = perDaytt[index];
        var (start, end) = SlotData.getSlotTime(
          slotLabel: SlotData.getSlotFromIndex(entry.slotIdentifier),
          date: entry.date,
          batch: entry.batch,
        );
        if (start == null || end == null) {
          start = "start time";
          end = "end time";
          return null;
        }
        return Card(
          color: theme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: sw * 0.02,
            vertical: sw * 0.01,
          ),
          elevation: 1,
          child: InkWell(
            onTap: () {
              // You can add navigation or other logic here
            },
            splashColor: theme.surface,
            highlightColor: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sw * 0.04,
                vertical: sw * 0.03,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: theme.onSurface,
                    radius: sw * 0.06,
                    child: Text(
                      SlotData.getSlotFromIndex(entry.slotIdentifier),
                      style: TextStyle(
                        color: theme.surface,
                        fontWeight: FontWeight.bold,
                        fontSize: sw * 0.045,
                      ),
                    ),
                  ),
                  SizedBox(width: sw * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          CourseData.getCoursebyId(
                            entry.courseIdentifier,
                          ).title,
                          style: TextStyle(fontSize: sw * 0.043),
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                        SizedBox(height: sw * 0.01),
                        Text(
                          "$start - $end",
                          style: TextStyle(
                            fontVariations: [FontVariation.weight(700)],
                          ),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (entry.active == false)
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Cancelled",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  if (entry.active == true && entry.type == "MODIFIED")
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Rescheduled",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  int _getValue(TimeTableEntry a) {
    final time = SlotData.getStartTime(
      slotLabel: SlotData.getSlotFromIndex(a.slotIdentifier),
      date: a.date,
      batch: a.batch,
    );
    final fallbackTime = DateTime.parse(a.date).add(const Duration(days: 1));
    final effectiveTime = (time == null) ? fallbackTime : time;
    return (a.batch == Batch.morning)
        ? effectiveTime.millisecondsSinceEpoch + 1
        : effectiveTime.millisecondsSinceEpoch;
  }
}
