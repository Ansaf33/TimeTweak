import 'package:flutter/material.dart';
import 'package:time_tweak/app_data.dart';
import 'package:time_tweak/screens/course_selection.dart';
import 'package:time_tweak/screens/sign_in.dart';
import 'package:time_tweak/services_and_models/utils.dart';
import 'package:time_tweak/widgets/error_display.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: sw * 0.04, top: sw * 0.05),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: sw * 0.04),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_rounded, size: sw * 0.1),
                    ),
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: sw * 0.08,
                      fontVariations: [FontVariation.weight(600)],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: sh * 0.04),
              child: CircleAvatar(
                radius: sw * 0.2,
                backgroundColor:
                    Colors
                        .primaries[CurrentUserData.name.length %
                            Colors.primaries.length]
                        .shade700,
                child: Text(
                  CurrentUserData.name[0],
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontVariations: [FontVariation.weight(500)],
                    fontSize: sw * 0.18,
                  ),
                ),
              ),
            ),
            SizedBox(height: sh * 0.02),
            Divider(
              indent: sw * 0.05,
              endIndent: sw * 0.05,
            ), // Add some spacing
            Expanded(
              // Wrap the scrollable content in Expanded
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: sh * 0.03),
                      // Name Row
                      Row(
                        children: [
                          Text(
                            "Name:           ",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: Colors.black45,
                              fontSize: sw * 0.05,
                              fontVariations: [FontVariation.weight(700)],
                            ),
                          ),
                          SizedBox(width: sw * 0.02),
                          Expanded(
                            child: Text(
                              CurrentUserData.name,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: sw * 0.05,
                                fontVariations: [FontVariation.weight(700)],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sh * 0.03),
                      Row(
                        children: [
                          Text(
                            "${CurrentUserData.idRelation}          ",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: Colors.black45,
                              fontSize: sw * 0.05,
                              fontVariations: [FontVariation.weight(700)],
                            ),
                          ),
                          SizedBox(width: sw * 0.02),
                          Expanded(
                            child: Text(
                              CurrentUserData.rollNum,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: sw * 0.048,
                                fontVariations: [FontVariation.weight(700)],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (CurrentUserData.role != Role.faculty)
                        SizedBox(height: sh * 0.03),
                      if (CurrentUserData.role != Role.faculty)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Branch:       ",
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                color: Colors.black45,
                                fontSize: sw * 0.05,
                                fontVariations: [FontVariation.weight(700)],
                              ),
                            ),
                            SizedBox(width: sw * 0.02),
                            Expanded(
                              child: SizedBox(
                                child: Text(
                                  CurrentUserData.branch,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: sw * 0.04,
                                    fontVariations: [FontVariation.weight(700)],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (CurrentUserData.role != Role.faculty)
                        SizedBox(height: sh * 0.03),
                      // Batch Row
                      if (CurrentUserData.role != Role.faculty)
                        Row(
                          children: [
                            Text(
                              "Batch:          ",
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                color: Colors.black45,
                                fontSize: sw * 0.05,
                                fontVariations: [FontVariation.weight(700)],
                              ),
                            ),
                            SizedBox(width: sw * 0.02),
                            Expanded(
                              child: Text(
                                CurrentUserData.batchAsString,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: sw * 0.05,
                                  fontVariations: [FontVariation.weight(700)],
                                ),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: sh * 0.02),
                      Theme(
                        data: Theme.of(context).copyWith(
                          splashColor:
                              Colors.transparent, // Removes splash effect
                          highlightColor:
                              Colors.transparent, // Removes highlight effect
                        ),
                        child: ValueListenableBuilder(
                          valueListenable: Rebuild.ec,
                          builder:
                              (context, value, _) => ExpansionTile(
                                trailing: Icon(Icons.unfold_more),
                                tilePadding: EdgeInsets.zero,
                                title: Text(
                                  CurrentUserData.courseRelation,
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Colors.black45,
                                    fontSize: sw * 0.05,
                                    fontVariations: [FontVariation.weight(700)],
                                  ),
                                ),
                                children:
                                    CurrentUserData.courses
                                        .map(
                                          (course) => ListTile(
                                            title: Text(
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                              course.title,
                                              style: TextStyle(
                                                fontSize: sw * 0.05,
                                                fontVariations: [
                                                  FontVariation.weight(700),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                        ),
                      ),
                      SizedBox(height: sh * 0.02),
                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: sw * 0.12,
                            child: OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.black87,
                                ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (ctx) => CourseSelectionScreen(
                                          isSignUp: false,
                                        ),
                                  ),
                                );
                              },
                              child: Text(
                                " Edit courses ",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: 'Outfit',
                                  fontSize: sw * 0.052,
                                  fontVariations: [FontVariation.weight(550)],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sw * 0.12,
                            child: OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.black87,
                                ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () => _changePassword(context),
                              child: Text(
                                "Change password",
                                style: TextStyle(
                                  color: Colors.red[300],
                                  fontFamily: 'Outfit',
                                  fontSize: sw * 0.038,
                                  fontVariations: [FontVariation.weight(700)],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sh * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: sw * 0.13,
                            width: sw * 0.5,
                            child: OutlinedButton(
                              style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.red[400],
                                ),
                              ),
                              onPressed: () => _logout(context),
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Outfit',
                                  fontSize: sw * 0.05,
                                  fontVariations: [FontVariation.weight(700)],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sh * 0.02),
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

  void _logout(BuildContext context) {
    CurrentUserData.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (ctx) => SignInScreen()),
      (route) => false,
    );
  }

  void _changePassword(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Change Password"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: oldPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Old Password"),
                  ),
                  TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: "New Password"),
                  ),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm New Password",
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                onPressed: () {
                  final oldPwd = oldPasswordController.text.trim();
                  final newPwd = newPasswordController.text.trim();
                  final confirmPwd = confirmPasswordController.text.trim();

                  if (newPwd != confirmPwd) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("New passwords do not match")),
                    );
                    return;
                  }

                  if (oldPwd.isEmpty || newPwd.isEmpty) {
                    ErrorDisplay.showSnackBar("Please fill all fields");
                    return;
                  }

                  // TODO: Handle actual password change logic

                  Navigator.pop(context); // Close the dialog
                },
                child: Text(
                  "Change Password",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}

//TODO Assign Functions to the three buttons
