// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tweak/services_and_models/models.dart';
import 'package:time_tweak/services_and_models/services.dart';

enum Role { student, cr, faculty }

extension RoleExtension on Role {
  String get backendEnum {
    switch (this) {
      case Role.faculty:
        return "FACULTY";
      case Role.cr:
        return "CLASS_REP";
      default:
        return "STUDENT";
    }
  }
}

enum Batch { morning, afternoon }

extension BatchExtension on Batch {
  String get backendEnum {
    switch (this) {
      case Batch.morning:
        return "MORNING";
      default:
        return "AFTERNOON";
    }
  }
}

enum Status { pending, approved, rejected }

extension StatusExtension on Status {
  String get displayValue {
    switch (this) {
      case Status.approved:
        return "Approved";
      case Status.rejected:
        return "Rejected";
      default:
        return "Pending";
    }
  }

  String get backendEnum {
    switch (this) {
      case Status.approved:
        return "APPROVED";
      case Status.rejected:
        return "REJECTED";
      default:
        return "PENDING";
    }
  }

  Color get color {
    switch (this) {
      case Status.approved:
        return Colors.green;
      case Status.rejected:
        return Colors.red;
      default:
        return Colors.yellow[600]!;
    }
  }

  IconData get icon {
    switch (this) {
      case Status.approved:
        return Icons.task_alt_rounded;
      case Status.rejected:
        return Icons.error_outline_outlined;
      default:
        return Icons.help_outline_rounded;
    }
  }
}

class CurrentUserData {
  // Attributes
  static String name = "Defaultname";
  static String rollNum = "DefaultRollNumber";
  static Batch batch = Batch.morning;
  static String passwd = "defaultpassword";
  static List<Course> courses = [];
  static List<Appointment> apps = [];
  static List<Reschedule> resc = [];
  static Role role = Role.student;

  //batch & branch is an invalid property for faculty
  static String get batchAsString =>
      (role == Role.faculty)
          ? ""
          : (batch == Batch.morning)
          ? "Morning"
          : "Evening";

  static String get branchCode =>
      (role == Role.faculty)
          ? ""
          : rollNum.substring(rollNum.length - 2).toUpperCase();

  static String get branch => (role == Role.faculty) ? "" : _getBranchName();

  //get Branch
  static String _getBranchName() {
    String branchCode = rollNum.substring(rollNum.length - 2).toUpperCase();
    final Map<String, String> branchMap = {
      "CS": "Computer Science and Engineering",
      "EC": "Electronics and Communication Engineering",
      "EE": "Electrical Engineering",
      "ME": "Mechanical Engineering",
      "PE": "Production Engineering",
      "EP": "Engineering Physics",
      "MT": "Material Science and Engineering",
      "CE": "Civil Engineering",
      "AR": "Architecture",
      "CH": "Chemical Engineering",
      "BT": "Biotechnology",
    };
    return branchMap[branchCode.toUpperCase()] ?? 'Unknown Branch';
  }

  //getters for relations
  static String get courseRelation =>
      (role == Role.faculty) ? "Courses Offered" : "Enrolled Courses";

  static String get idRelation =>
      (role == Role.faculty) ? "Identifier" : "RegNo";

  static void clear() {
    name = "DefaultName";
    rollNum = "DefaultRollNumber";
    batch = Batch.morning;
    passwd = "defaultpassword";
    courses = [];
    apps = [];
    resc = [];
    role = Role.student;
  }
}

class CourseData {
  static List<Course> allcourses = [];

  static void clearCourses() {
    allcourses = [];
  }

  static Course getCoursebyId(String courseId) {
    try {
      final course = CourseData.allcourses.firstWhere(
        (course) => course.courseId == courseId,
        orElse:
            () =>
                Course(courseId: courseId, title: "Unknown title", timings: []),
      );
      return course;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Course? getCourseByName(String? courseName) {
    try {
      if (courseName == null) return null;
      return CourseData.allcourses.firstWhere(
        (course) => course.title == courseName,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

class CRData {
  static List<ClassRep> allCRs = [];

  static ClassRep getCRbyId(String regNo) {
    try {
      return CRData.allCRs.firstWhere(
        (cr) => cr.regNo == regNo,
        orElse:
            () => ClassRep(
              regNo: regNo,
              name: "Unknown",
              password: "Unknown",
              batch: Batch.morning,
            ),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

class StudentData {
  static Future<Student> getStudentbyId(String regNo) async {
    try {
      final (check, msg) = await StudentService.fetch(regNo: regNo);
      if (check) {
        return Student.fromJson(msg);
      } else {
        return Student(
          regNo: regNo,
          batch: Batch.morning,
          name: regNo,
          password: "Password",
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

class FacultyData {
  static List<Faculty> allFaculties = [];

  static Faculty getFacultybyId(String facId) {
    try {
      return FacultyData.allFaculties.firstWhere(
        (faculty) => faculty.facId == facId,
        orElse:
            () => Faculty(facId: facId, name: "Unknown", password: "Unknown"),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Faculty? getFacultybyName(String? name) {
    try {
      if (name == null) return null;
      return FacultyData.allFaculties.firstWhere(
        (faculty) => faculty.name == name,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

class SlotData {
  static const List<String> allSlots = [
    "A1",
    "B1",
    "C1",
    "D1",
    "E1",
    "A2",
    "B2",
    "C2",
    "D2",
    "E2",
    "A1P",
    "B1P",
    "C1P",
    "D1P",
    "E1P",
    "A2P",
    "B2P",
    "C2P",
    "D2P",
    "E2P",
    "F",
    "G",
    "H",
    "FP",
    "P1",
    "Q1",
    "R1",
    "S1",
    "T1",
    "P2",
    "Q2",
    "R2",
    "S2",
    "T2",
    "PA1",
    "PB1",
    "QA1",
    "QB1",
    "RA1",
    "RB1",
    "SA1",
    "SB1",
    "TA1",
    "TB1",
    "PA2",
    "PB2",
    "QA2",
    "QB2",
    "RA2",
    "RB2",
    "SA2",
    "SB2",
    "TA2",
    "TB2",
  ];

  static const Map<String, Map<String, String>> morningSlotTimings = {
    'Mon': {
      'F': '08:00 AM-08:50 AM',
      'A1': '09:00 AM-09:50 AM',
      'B1': '10:00 AM-10:50 AM',
      'C1': '11:00 AM-11:50 AM',
      'D1+': '12:00 PM-12:50 PM',
      'P1': '02:00 PM-04:50 PM',
      'PA1': '02:00 PM-03:50 PM',
      'PB1': '04:00 PM-05:50 PM',
      'G': '05:00 PM-05:50 PM',
    },
    'Tue': {
      'H': '08:00 AM-08:50 AM',
      'B1': '09:00 AM-09:50 AM',
      'C1': '10:00 AM-10:50 AM',
      'D1': '11:00 AM-11:50 AM',
      'E1+': '12:00 PM-12:50 PM',
      'Q1': '02:00 PM-04:50 PM',
      'QA1': '02:00 PM-03:50 PM',
      'QB1': '04:00 PM-05:50 PM',
      'F': '05:00 PM-05:50 PM',
    },
    'Wed': {
      'G': '08:00 AM-08:50 AM',
      'C1': '09:00 AM-09:50 AM',
      'D1': '10:00 AM-10:50 AM',
      'E1': '11:00 AM-11:50 AM',
      'A1+': '12:00 PM-12:50 PM',
      'R1': '02:00 PM-04:50 PM',
      'RA1': '02:00 PM-03:50 PM',
      'RB1': '04:00 PM-05:50 PM',
      'H': '05:00 PM-05:50 PM',
    },
    'Thu': {
      'F': '08:00 AM-08:50 AM',
      'D1': '09:00 AM-09:50 AM',
      'E1': '10:00 AM-10:50 AM',
      'A1': '11:00 AM-11:50 AM',
      'B1+': '12:00 PM-12:50 PM',
      'S1': '02:00 PM-04:50 PM',
      'SA1': '02:00 PM-03:50 PM',
      'SB1': '04:00 PM-05:50 PM',
      'G': '05:00 PM-05:50 PM',
    },
    'Fri': {
      'H': '08:00 AM-08:50 AM',
      'E1': '09:00 AM-09:50 AM',
      'A1': '10:00 AM-10:50 AM',
      'B1': '11:00 AM-11:50 AM',
      'C1+': '12:00 PM-12:50 PM',
      'T1': '02:00 PM-04:50 PM',
      'TA1': '02:00 PM-03:50 PM',
      'TB1': '04:00 PM-05:50 PM',
      'F+': '05:00 PM-05:50 PM',
    },
  };

  static const Map<String, Map<String, String>> afternoonSlotTimings = {
    'Mon': {
      'F': '08:00 AM-08:50 AM',
      'P2': '09:00 AM-11:50 AM',
      'PA2': '08:00 AM-09:50 AM',
      'PB2': '10:00 AM-11:50 AM',
      'D2+': '01:00 PM-01:50 PM',
      'A2': '02:00 PM-02:50 PM',
      'B2': '03:00 PM-03:50 PM',
      'C2': '04:00 PM-04:50 PM',
      'G': '05:00 PM-05:50 PM',
    },
    'Tue': {
      'H': '08:00 AM-08:50 AM',
      'Q2': '09:00 AM-11:50 AM',
      'QA2': '08:00 AM-09:50 AM',
      'QB2': '10:00 AM-11:50 AM',
      'E2+': '01:00 PM-01:50 PM',
      'B2': '02:00 PM-02:50 PM',
      'C2': '03:00 PM-03:50 PM',
      'D2': '04:00 PM-04:50 PM',
      'F': '05:00 PM-05:50 PM',
    },
    'Wed': {
      'G': '08:00 AM-08:50 AM',
      'R2': '09:00 AM-11:50 AM',
      'RA2': '08:00 AM-09:50 AM',
      'RB2': '10:00 AM-11:50 AM',
      'A2+': '01:00 PM-01:50 PM',
      'C2': '02:00 PM-02:50 PM',
      'D2': '03:00 PM-03:50 PM',
      'E2': '04:00 PM-04:50 PM',
      'H': '05:00 PM-05:50 PM',
    },
    'Thu': {
      'F': '08:00 AM-08:50 AM',
      'S2': '09:00 AM-11:50 AM',
      'SA2': '08:00 AM-09:50 AM',
      'SB2': '10:00 AM-11:50 AM',
      'B2+': '01:00 PM-01:50 PM',
      'D2': '02:00 PM-02:50 PM',
      'E2': '03:00 PM-03:50 PM',
      'A2': '04:00 PM-04:50 PM',
      'G': '05:00 PM-05:50 PM',
    },
    'Fri': {
      'H': '08:00 AM-08:50 AM',
      'T2': '09:00 AM-11:50 AM',
      'TA2': '08:00 AM-09:50 AM',
      'TB2': '10:00 AM-11:50 AM',
      'C2+': '01:00 PM-01:50 PM',
      'E2': '02:00 PM-02:50 PM',
      'A2': '03:00 PM-03:50 PM',
      'B2': '04:00 PM-04:50 PM',
      'F+': '05:00 PM-05:50 PM',
    },
  };

  static DateTime? getStartTime({
    required String slotLabel,
    required String date, // Format: yyyy-MM-dd
    required Batch batch,
  }) {
    final (start, _) = getSlotTime(
      slotLabel: slotLabel,
      date: date,
      batch: batch,
    );

    if (start == null) return null;
    final format = DateFormat('yyyy-MM-dd hh:mm a');
    final dateTimeStr = "$date $start";
    return format.parse(dateTimeStr);
  }

  

  //Nullable
  static (String?, String?) getSlotTime({
    required String slotLabel,
    required String date, // Format: yyyy-MM-dd
    required Batch batch, // "MORNING" or "AFTERNOON"
  }) {
    final weekday = DateTime.parse(date).weekday;
    final dayName =
        ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][weekday - 1];

    final slotMap =
        batch == Batch.morning
            ? morningSlotTimings[dayName]
            : afternoonSlotTimings[dayName];
    if (slotMap == null) return (null, null);
    final timings = slotMap[slotLabel];
    if (timings == null) return (null, null);
    final startEnd = timings.split('-');
    return (startEnd[0], startEnd[1]);
  }

  /// Get slot name from integer
  static String getSlotFromIndex(int index) {
    if (index < 0 || index >= allSlots.length) {
      throw Exception("Invalid slot index: $index");
    }
    return allSlots[index];
  }

  /// Get index from slot name
  static int getIndexFromSlot(String slot) {
    int index = allSlots.indexOf(slot.toUpperCase());
    if (index == -1) {
      throw Exception("Invalid slot name: $slot");
    }
    return index;
  }
}

class TimeTableData {
  static List<TimeTableEntry> tt = [];

  static void filterEntriesByCourses() {
    final List<TimeTableEntry> allEntries = tt;
    // Extract the course IDs from the course list
    final Set<String> courseIds =
        CurrentUserData.courses.map((c) => c.courseId).toSet();

    // Filter the timetable entries
    tt =
        allEntries
            .where((entry) => courseIds.contains(entry.courseIdentifier))
            .toList();
  }
}
