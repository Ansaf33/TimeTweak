import 'package:flutter/material.dart';
import 'package:time_tweak/app_data.dart';

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
              padding: EdgeInsets.only(top: sh * 0.02),
              child: CircleAvatar(radius: sw * 0.25),
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
                              ProfileData.name,
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
                            ProfileData.idRelation,
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
                              ProfileData.id,
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
                      SizedBox(height: sh * 0.03),
                      // Passwd Row
                      Row(
                        children: [
                          Text(
                            "Password:  ",
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
                              "•" * ProfileData.passwd.length,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: sw * 0.05,
                                fontVariations: [FontVariation.weight(700)],
                              ),
                            ),
                          ),
                          SizedBox(width: sw * 0.03),
                        ],
                      ),
                      // Branch Row
                      if (ProfileData.role != Role.faculty)
                        SizedBox(height: sh * 0.03),
                      if (ProfileData.role != Role.faculty)
                        Row(
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
                              child: Text(
                                ProfileData.branch,
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
                      if (ProfileData.role != Role.faculty)
                        SizedBox(height: sh * 0.03),
                      // Batch Row
                      if (ProfileData.role != Role.faculty)
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
                                ProfileData.batch,
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
                        child: ExpansionTile(
                          trailing: Icon(Icons.unfold_more),
                          tilePadding: EdgeInsets.zero,
                          title: Text(
                            ProfileData.courseRelation,
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: Colors.black45,
                              fontSize: sw * 0.05,
                              fontVariations: [FontVariation.weight(700)],
                            ),
                          ),
                          children:
                              ProfileData.courses
                                  .map(
                                    (course) => ListTile(
                                      title: Text(
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        course,
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
                              onPressed: () {},
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
                              onPressed: () {},
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
                              onPressed: () {},
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
}


//TODO Assign Functions to the three buttons
