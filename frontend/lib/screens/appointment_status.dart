import 'package:flutter/material.dart';
import 'package:time_tweak/app_data.dart';

class AppointmentStatus extends StatelessWidget {
  const AppointmentStatus({super.key});

  final String currDate = "22-03-2026";
  final String newDate = "22-03-2025";
  final String currSlot = "A1";
  final String newSlot = "B1";
  final String remark = "please cancel";
  final String faculty = "Saleena Nazeer";
  final String course = "Compiler Design";
  final Status status = Status.approved;

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: sw * 0.04, top: sw * 0.04),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: sw * 0.02),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_rounded, size: sw * 0.08),
                    ),
                  ),
                  Text(
                    "Appointment",
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: sw * 0.07,
                      fontVariations: [FontVariation.weight(700)],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: sh * 0.03),
                    Padding(
                      //Description
                      padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                      child: TextFormField(
                        initialValue: remark,
                        enabled: false,
                        maxLines: 3,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: sh * 0.02,
                        left: sw * 0.05,
                        right: sw * 0.05,
                      ),
                      child: TextFormField(
                        initialValue: faculty,
                        ignorePointers: true,
                        enabled: false,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: sh * 0.02),
                    Divider(
                      thickness: 2,
                      indent: sw * 0.05,
                      endIndent: sw * 0.05,
                      color: Colors.grey[400],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: sw * 0.05),
                      child: Text(
                        "Requested",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: sh * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: currDate,
                              enabled: false,
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: sw * 0.05),
                          Expanded(
                            child: TextFormField(
                              initialValue: currSlot,
                              enabled: false,
                              decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sh * 0.02),
                    Divider(
                      thickness: 2,
                      indent: sw * 0.05,
                      endIndent: sw * 0.05,
                      color: Colors.grey[400],
                    ),

                    if (status == Status.rejected)
                      Padding(
                        padding: EdgeInsets.only(left: sw * 0.05),
                        child: Text(
                          "Suggested",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    if (status == Status.rejected) SizedBox(height: sh * 0.02),
                    if (status == Status.rejected)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: newDate,
                                enabled: false,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: sw * 0.05),
                            Expanded(
                              child: TextFormField(
                                initialValue: newSlot,
                                enabled: false,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    SizedBox(height: sh * 0.03),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                      child: Row(
                        children: [
                          Text(
                            "Status:  ",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: sw * 0.06,
                              fontVariations: [FontVariation.weight(700)],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: sh * 0.07,
                              child: TextFormField(
                                initialValue: status.displayValue,
                                enabled: false,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: sw * 0.05,
                                  color: status.color,
                                  fontVariations: [FontVariation.weight(700)],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (status == Status.rejected) SizedBox(height: sh * 0.06),
                    if (status == Status.rejected) Center(
                      child: SizedBox(
                        height: sw * 0.13,
                        width: sw * 0.7,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          child: Text(
                            "Request Suggested Slot",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontFamily: 'Outfit',
                              fontSize: sw * 0.05,
                              fontVariations: [FontVariation.weight(500)],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: sh * 0.05),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
