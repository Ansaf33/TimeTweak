import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_tweak/app_data.dart';
import 'package:time_tweak/defaults.dart';
import 'package:time_tweak/main.dart';
import 'package:time_tweak/screens/home.dart';
import 'package:time_tweak/services_and_models/models.dart';
import 'package:time_tweak/services_and_models/services.dart';
import 'package:time_tweak/services_and_models/utils.dart';
import 'package:time_tweak/widgets/error_display.dart';
import 'package:time_tweak/widgets/loading.dart';

class CourseSelection extends StatefulWidget {
  const CourseSelection({super.key, required this.isSignUp});

  final bool isSignUp;

  @override
  CourseSelectionScreenState createState() => CourseSelectionScreenState();
}

class CourseSelectionScreenState extends State<CourseSelection> {
  List<Course> _filteredCourses = [];
  final Set<Course> _selectedCourses = CurrentUserData.courses.toSet();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCourses = List.from(CourseData.allcourses);
  }

  void updateSearch(String query) {
    setState(() {
      _filteredCourses =
          CourseData.allcourses
              .where(
                (course) =>
                    course.title.toLowerCase().contains(query.toLowerCase()) ||
                    course.courseId.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  void toggleSelection(Course course) {
    setState(() {
      if (_selectedCourses.any((c) => c.courseId == course.courseId)) {
        _selectedCourses.removeWhere((c) => c.courseId == course.courseId);
      } else {
        _selectedCourses.add(course);
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
                  Padding(
                    padding: EdgeInsets.only(left: sw * 0.05, right: sw * 0.24),
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
                    onPressed: () => _updateCourses(),
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
                controller: _searchController,
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
          if (_selectedCourses.isNotEmpty)
            SizedBox(
              height: sh * 0.06,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    _selectedCourses.map((course) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Chip(
                          label: Text(
                            course.title,
                            style: GoogleFonts.sourceCodePro(
                              color: surfaceLight,
                            ),
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
              itemCount: _filteredCourses.length,
              itemBuilder: (context, index) {
                final course = _filteredCourses[index];
                final isSelected = _selectedCourses.any(
                  (c) => c.courseId == course.courseId,
                );

                return GestureDetector(
                  onTap: () => toggleSelection(course),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(
                      horizontal: sh * 0.015,
                      vertical: sh * 0.005,
                    ),
                    padding: EdgeInsets.all(sh * 0.02),
                    decoration: BoxDecoration(
                      color: isSelected ? onSurfaceLight : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? surfaceLight : Colors.grey[400]!,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(color: onSurfaceLight, blurRadius: 5),
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
                            "${course.courseId} - ${course.title}",
                            style: GoogleFonts.outfit(
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

  void _updateCourses() async {
    Loading.show();
    try {
      if (_selectedCourses.isEmpty) {
        return ErrorDisplay.showSnackBar("Select atleast one course");
      }
      if (CurrentUserData.role == Role.faculty) {
        final current = await FacultyService.courses(
          facID: CurrentUserData.rollNum,
        );
        if (current == null) {
          return;
        }
        Set<String> currentIds = current.map((c) => c.courseId).toSet();
        Set<String> selectedIds =
            _selectedCourses.map((s) => s.courseId).toSet();
        for (String courseId in selectedIds) {
          if (currentIds.contains(courseId)) {
            continue;
          }
          final (res, msg) = await FacultyService.addCourse(
            facId: CurrentUserData.rollNum,
            courseId: courseId,
          );
          if (!res) {
            return ErrorDisplay.showSnackBar(msg);
          }
        }

        //TODO Remove course facility
      } else {
        final current = await StudentService.enrolled(
          regNo: CurrentUserData.rollNum,
        );
        if (current == null) {
          return;
        }
        Set<String> currentIds = current.map((c) => c.courseId).toSet();
        Set<String> selectedIds =
            _selectedCourses.map((s) => s.courseId).toSet();
        for (String courseId in selectedIds) {
          if (currentIds.contains(courseId)) {
            continue;
          }
          final (res, msg) = await StudentService.addCourse(
            regNo: CurrentUserData.rollNum,
            courseId: courseId,
          );
          if (!res) {
            return ErrorDisplay.showSnackBar(msg);
          }
        }
        for (String courseId in currentIds) {
          if (selectedIds.contains(courseId)) {
            continue;
          }
          final (res, msg) = await StudentService.removeCourse(
            regNo: CurrentUserData.rollNum,
            courseId: courseId,
          );
          if (!res) {
            return ErrorDisplay.showSnackBar(msg);
          }
        }
      }
      CurrentUserData.courses = _selectedCourses.toList();
      await TimetableService.getAll();
      Rebuild.enrolledCourses();
      Rebuild.timetables();
      if (widget.isSignUp) {
        Loading.close();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainSchedule()),
          (route) => false,
        );
        return;
      }
      Navigator.pop(context);
      return;
    } finally {
      Loading.close();
    }
  }
}

class CourseSelectionScreen extends StatelessWidget {
  const CourseSelectionScreen({super.key, required this.isSignUp});

  final bool isSignUp;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Loading.show();
      await CourseService.fetchAll();
      Loading.close();
      final BuildContext? navCtx = navigatorKey.currentContext;
      if (navCtx == null) {
        throw Exception("Context not available for course selection");
      }
      if (navCtx.mounted) {
        Navigator.pushReplacement(
          navCtx,
          MaterialPageRoute(
            builder: (ctx) => CourseSelection(isSignUp: isSignUp),
          ),
        );
      }
    });
    return Scaffold();
  }
}
