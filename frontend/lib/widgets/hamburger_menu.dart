import 'package:flutter/material.dart';
import 'package:time_tweak/screens/appointments.dart';
import 'package:time_tweak/screens/profile.dart';
import 'package:time_tweak/screens/requests.dart';
import 'package:time_tweak/screens/reschedule.dart';

enum PageNumber { home, rescheduling, requests, appointments, about, profile }

class CustomDrawer {
  static PageNumber value = PageNumber.home;
  static bool _isnavigating = false;

  static void showMiniDrawer(BuildContext context) {
    value = _getCurrentPage(context);
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      pageBuilder:
          (context, animation, secondaryAnimation) => const SizedBox.shrink(),
      transitionDuration: const Duration(milliseconds: 500), // Duration here
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(-1.0, 0.0), // Slide in from left
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubicEmphasized,
          ),
        );

        return SlideTransition(
          position: slideAnimation,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.6,
              heightFactor: 1.0,
              child: Material(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.only(bottom: sw * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: sh * 0.06,
                          left: sw * 0.03,
                          bottom: sh * 0.01,
                        ),
                        child: Text(
                          "TimeTweak",
                          style: TextStyle(
                            fontFamily: 'Loranthus',
                            fontSize: sw * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(),
                      //----------------------------------------------------------------Home Tile Implemented differently
                      ListTile(
                        selected: (value == PageNumber.home) ? true : false,
                        selectedTileColor: Color.fromARGB(255, 145, 149, 149),
                        leading: const Icon(Icons.calendar_month_sharp),
                        title: Text(
                          'My Schedule',
                          style: TextStyle(fontSize: sw * 0.045),
                        ),
                        onTap: () {
                          if (_isnavigating) {
                            return;
                          } else {
                            _isnavigating = true;
                          }
                          if (value != PageNumber.home) {
                            CustomDrawer.value = PageNumber.home;
                            Navigator.of(
                              context,
                            ).popUntil((route) => route.isFirst);
                          } else {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          }
                          _isnavigating = false;
                        },
                      ),
                      //-----------------------------------------------------------------------Home tile ends Secondary tiles given below
                      _buildSecondaryPage(
                        sw,
                        context,
                        "Reschedule",
                        Icons.autorenew_rounded,
                        PageNumber.rescheduling,
                        Reschedule(),
                      ),
                      _buildSecondaryPage(
                        sw,
                        context,
                        "Appointments",
                        Icons.list_alt,
                        PageNumber.appointments,
                        Appointments(),
                      ),
                      _buildSecondaryPage(
                        sw,
                        context,
                        "Requests",
                        Icons.message_outlined,
                        PageNumber.requests,
                        Requests(),
                      ),
                      Flexible(child: SizedBox.expand()),
                      Divider(),
                      _buildSecondaryPage(
                        sw,
                        context,
                        "My Profile",
                        Icons.person_pin,
                        PageNumber.profile,
                        Profile(),
                      ),
                      _buildSecondaryPage(
                        sw,
                        context,
                        "About us",
                        Icons.info_outline_rounded,
                        PageNumber.about,
                        Reschedule(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static ListTile _buildSecondaryPage(
    double sw,
    BuildContext context,
    final String name,
    final IconData icon,
    final itemValue,
    Widget page,
  ) {
    return ListTile(
      selected: (value == itemValue) ? true : false,
      selectedTileColor: Color.fromARGB(255, 145, 149, 149),
      leading: Icon(icon),
      title: Text(name, style: TextStyle(fontSize: sw * 0.045)),
      onTap: () async {
        if (_isnavigating) {
          return;
        } else {
          _isnavigating = true;
        }
        if (value != itemValue) {
          Navigator.of(context).pushAndRemoveUntil(
            _slideNewpage(page),
            (route) => route.isFirst,
          );
          CustomDrawer.value = itemValue;
        } else {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
        _isnavigating = false;
      },
    );
  }

  static PageRouteBuilder<dynamic> _slideNewpage(Widget newPage) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => newPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from right
        const end = Offset.zero; // Slide in
        const curve = Curves.easeInOut;

        var slideTween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(slideTween),
          child: child,
        );
      },
    );
  }

  static PageNumber _getCurrentPage(BuildContext context) {
    String currentPage = context.widget.runtimeType.toString();
    switch (currentPage) {
      case "MainSchedule":
        return PageNumber.home;
      case "Reschedule":
        return PageNumber.rescheduling;
      case "Profile":
        return PageNumber.profile;
      case "AboutUs":
        return PageNumber.about;
      case "Appointments":
        return PageNumber.appointments;
      case "Requests":
        return PageNumber.requests;
      default:
        return PageNumber.home;
    }
  }
}
