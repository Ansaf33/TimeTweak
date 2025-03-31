import 'package:flutter/material.dart';
import 'package:time_tweak/screens/reschedule_form.dart';
import 'package:time_tweak/widgets/hamburger_menu.dart';

class Reschedule extends StatelessWidget {
  const Reschedule({super.key});

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
            Expanded(
              child: ListView.builder(
                itemCount: 30,
                itemBuilder:
                    (context, index) => Card(
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
                        onTap: () {}, //TODO Open appointment status
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
                                Icons.error_outline_rounded,
                                color: Colors.redAccent,
                                size: sw * 0.09,
                              ),
                              SizedBox(width: sw * 0.04),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Compiler Design",
                                      style: TextStyle(fontSize: sw * 0.043),
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                    ),
                                    SizedBox(height: sw * 0.01),
                                    Text(
                                      "Saleena Nazeer",
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
                                    "25-03-2025",
                                    style: TextStyle(
                                      fontFamily: 'Loranthus',
                                      fontSize: sw * 0.03,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Wednesday",
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
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
