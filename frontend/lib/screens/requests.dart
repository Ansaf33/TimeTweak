import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_tweak/app_data.dart';
import 'package:time_tweak/screens/appointment_request.dart.dart';
import 'package:time_tweak/screens/appointment_status.dart';
import 'package:time_tweak/screens/reschedule_request.dart';
import 'package:time_tweak/screens/reschedule_status.dart';
import 'package:time_tweak/services_and_models/models.dart';
import 'package:time_tweak/services_and_models/utils.dart';
import 'package:time_tweak/widgets/hamburger_menu.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final ColorScheme theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.secondary,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: theme.surface,
              child: Padding(
                padding: EdgeInsets.only(
                  left: sw * 0.04,
                  top: sw * 0.04,
                  bottom: sw * 0.03,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: sw * 0.02),
                      child: IconButton(
                        onPressed: () => CustomDrawer.showMiniDrawer(context),
                        icon: Icon(Icons.menu_rounded, size: sw * 0.08),
                      ),
                    ),
                    Text(
                      "Requests",
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: sw * 0.06,
                        fontVariations: [FontVariation.weight(700)],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            Expanded(
              child: DefaultTabController(
                length: 2,
                animationDuration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Container(
                      height: sw * 0.15,
                      decoration: BoxDecoration(
                        color: theme.surface,

                        border: Border.all(color: theme.onSurface, width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: sw * 0.03,
                        vertical: sw * 0.02,
                      ),
                      child: TabBar(
                        dividerHeight: 0,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: theme.onSurface, // Highlight selected tab
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelColor: theme.secondary,
                        unselectedLabelColor: theme.onSurface,
                        tabs: [
                          Tab(
                            child: Text(
                              "Rescheduling",
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: sw * 0.05,
                                fontVariations: [FontVariation.weight(600)],
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Appointments",
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: sw * 0.05,
                                fontVariations: [FontVariation.weight(600)],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: Rebuild.reqs,
                      builder:
                          (context, value, _) => Expanded(
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                2,
                                (index) =>
                                    _buildPage(context, index, sw, theme),
                              ),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(
    BuildContext context,
    int i,
    final double sw,
    final ColorScheme theme,
  ) {
    if ((CurrentUserData.resc.isEmpty && i == 0) ||
        (CurrentUserData.apps.isEmpty && i == 1)) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history, size: sw * 0.5, color: theme.onSecondary),
            Text(
              (i == 0)
                  ? "You have no reschedule requests"
                  : "You have no appointments",
              style: GoogleFonts.montserrat(
                color: theme.onSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
    if (i == 0) {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: CurrentUserData.resc.length,
        itemBuilder: (context, index) {
          final Reschedule resc = CurrentUserData.resc[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: sw * 0.02,
              vertical: sw * 0.01,
            ), // Padding Outside the card
            elevation: 1,
            child: InkWell(
              onTap: () {
                if (resc.status != Status.pending) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => RescheduleStatus(resc: resc),
                    ),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => RescheduleRequest(resc: resc),
                  ),
                );
                return;
              },
              splashColor: theme.secondary, // Ripple color
              highlightColor: Colors.grey, // Highlight color
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                //Padding inside the card
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.04,
                  vertical: sw * 0.03,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      resc.status.icon,
                      color: resc.status.color,
                      size: sw * 0.09,
                    ),
                    SizedBox(width: sw * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            CourseData.getCoursebyId(
                              resc.courseIdentifier,
                            ).title,
                            style: TextStyle(fontSize: sw * 0.043),
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(height: sw * 0.01),
                          Text(
                            resc.reason,
                            style: TextStyle(
                              fontVariations: [FontVariation.weight(700)],
                            ),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: sw * 0.03),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${resc.ogDate} - ${SlotData.getSlotFromIndex(resc.ogSlotIdentifier)}",
                          style: TextStyle(
                            fontFamily: 'Loranthus',
                            fontSize: sw * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${resc.newDate} - ${SlotData.getSlotFromIndex(resc.newSlotIdentifier)}",
                          style: TextStyle(
                            fontFamily: 'Loranthus',
                            fontSize: sw * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: CurrentUserData.apps.length,
        itemBuilder: (context, index) {
          final Appointment app = CurrentUserData.apps[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: sw * 0.02,
              vertical: sw * 0.01,
            ), // Padding Outside the card
            elevation: 1,
            child: InkWell(
              onTap: () {
                if (app.status != Status.pending) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => AppointmentStatus(app: app),
                    ),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => AppointmentRequest(app: app),
                  ),
                );
              },
              splashColor: theme.secondary, // Ripple color
              highlightColor: Colors.grey, // Highlight color
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                //Padding inside the card
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.04,
                  vertical: sw * 0.03,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      app.status.icon,
                      color: app.status.color,
                      size: sw * 0.09,
                    ),
                    SizedBox(width: sw * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            app.clientName,
                            style: TextStyle(fontSize: sw * 0.043),
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(height: sw * 0.01),
                          Text(
                            app.reason,
                            style: TextStyle(
                              fontVariations: [FontVariation.weight(700)],
                            ),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: sw * 0.03),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          app.date,
                          style: TextStyle(
                            fontFamily: 'Loranthus',
                            fontSize: sw * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          SlotData.getSlotFromIndex(app.slot),
                          style: TextStyle(
                            fontFamily: 'Loranthus',
                            fontSize: sw * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
