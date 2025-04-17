import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_tweak/app_data.dart';
import 'package:time_tweak/screens/reschedule_form.dart';
import 'package:time_tweak/screens/reschedule_status.dart';
import 'package:time_tweak/services_and_models/models.dart';
import 'package:time_tweak/widgets/hamburger_menu.dart';

class RescheduleScreen extends StatelessWidget {
  const RescheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    //final double sh = MediaQuery.of(context).size.height;
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
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: sw * 0.02),
                      child: IconButton(
                        onPressed: () => CustomDrawer.showMiniDrawer(context),
                        icon: Icon(Icons.menu_rounded, size: sw * 0.08),
                      ),
                    ),
                    Text(
                      "Rescheduling",
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: sw * 0.06,
                        fontVariations: [FontVariation.weight(700)],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: sw * 0.23),
                      child: IconButton(
                        onPressed:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RescheduleForm(),
                              ),
                            ),
                        icon: Icon(Icons.add_rounded, size: sw * 0.08),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            SizedBox(height: sw * 0.03),
            if(CurrentUserData.resc.isNotEmpty) Expanded(
              child: ListView.builder(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => RescheduleStatus(resc: resc),
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
                                    FacultyData.getFacultybyId(
                                      resc.facultyIdentifier,
                                    ).name,
                                    style: TextStyle(
                                      fontVariations: [
                                        FontVariation.weight(700),
                                      ],
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
              ),
            )
            else Expanded(child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history,
                  size: sw * 0.5,
                  color: theme.onSecondary
                ),
                Text("You have no Reschedule plans",
                style: GoogleFonts.montserrat(color: theme.onSecondary,fontWeight: FontWeight.bold),),
              ],
            )),),
          ],
        ),
      ),
    );
  }
}
