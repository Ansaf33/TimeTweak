import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_tweak/defaults.dart';

class CourseSelectionScreen extends StatefulWidget {
  const CourseSelectionScreen({super.key});

  @override
  CourseSelectionScreenState createState() => CourseSelectionScreenState();
}

class CourseSelectionScreenState extends State<CourseSelectionScreen> {
  final List<String> allCourses = [
    "Mathematics",
    "Physics",
    "Computer Science",
    "Electronics",
    "Mechanical Engineering",
    "Civil Engineering",
    "AI & ML",
    "Cybersecurity",
    "Data Science",
    "Digital Marketing",
    "Cloud Computing",
    "Software Engineering",
    "Blockchain",
    "Biotechnology",
    "Aerodynamics",
  ];

  List<String> filteredCourses = [];
  Set<String> selectedCourses = {};
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    filteredCourses = List.from(allCourses);
  }

  void updateSearch(String query) {
    setState(() {
      filteredCourses =
          allCourses
              .where(
                (course) => course.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  void toggleSelection(String course) {
    setState(() {
      if (selectedCourses.contains(course)) {
        selectedCourses.remove(course);
      } else {
        selectedCourses.add(course);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double sh = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 206, 205, 209),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 41, 41, 42),
            child: Padding(
              padding: EdgeInsets.only(
                top: sh * 0.05,
                left: sw * 0.02,
                right: sw * 0.05,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      color: surfaceLight,
                      Icons.arrow_back_ios_new_rounded,
                      size: sw * 0.08,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: sw * 0.02, right: sw * 0.16),
                    child: Text(
                      "Select courses",
                      style: TextStyle(
                        color: surfaceLight,
                        fontSize: sw * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      color: surfaceLight,
                      size: sw * 0.09,
                      Icons.check,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Search Bar
          Container(
            color: const Color.fromARGB(255, 41, 41, 42),
            child: Padding(
              padding: EdgeInsets.only(
                top: sh * 0.02,
                left: sw * 0.04,
                right: sw * 0.04,
                bottom: sh * 0.015,
              ),
              child: TextField(
                controller: searchController,
                onChanged: updateSearch,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 184, 184, 195),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search Courses...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),

          // Selected Courses as Chips
          if (selectedCourses.isNotEmpty)
            SizedBox(
              height: sh * 0.06,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    selectedCourses.map((course) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Chip(
                          label: Text(
                            course,
                            style: GoogleFonts.sourceCodePro(color: surfaceLight),
                          ),
                          backgroundColor: onSurfaceLight,
                          deleteIcon: Icon(
                            Icons.close_rounded,
                            color: surfaceLight,
                          ),
                          onDeleted: () => toggleSelection(course),
                        ),
                      );
                    }).toList(),
              ),
            ),

          // Scrollable Course List
          Expanded(
            child: ListView.builder(
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                final course = filteredCourses[index];
                final isSelected = selectedCourses.contains(course);

                return GestureDetector(
                  onTap: () => toggleSelection(course),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: sh * 0.015, vertical: sh * 0.005),
                    padding: EdgeInsets.all(sh * 0.02),
                    decoration: BoxDecoration(
                      color: isSelected ? onSurfaceLight : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            isSelected ? surfaceLight : Colors.grey[400]!,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(
                                  color: onSurfaceLight,
                                  blurRadius: 5,
                                ),
                              ]
                              : [],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            course,
                            style: GoogleFonts.bubblegumSans(
                              fontSize: sh * 0.022,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check_circle, color: Colors.white),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
