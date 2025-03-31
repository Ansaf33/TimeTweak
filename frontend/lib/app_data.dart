// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';

enum Role { student, cr, faculty }

enum Batch { morning, evening }

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

class ProfileData {
  // Attributes
  static String name = "John Doe";
  static String id = "B220012CS";
  static Batch _batch = Batch.morning;
  static String passwd = "j2ouj3rrf0923";
  static List<String> courses = [
    "Compiler Design",
    "Computer Networks",
    "Data Structures and Algorithms",
    "Database Management Systems",
    "Design and Analysis of Algorithms",
  ];
  static Role role = Role.student;

  //batch & branch is an invalid property for faculty
  static String get batch =>
      (role == Role.faculty)
          ? ""
          : (_batch == Batch.morning)
          ? "Morning"
          : "Evening";

  static String get branchCode =>
      (role == Role.faculty) ? "" : id.substring(id.length - 2).toUpperCase();

  static String get branch => (role == Role.faculty) ? "" : _getBranchName();

  //get Branch
  static String _getBranchName() {
    String branchCode = id.substring(id.length - 2).toUpperCase();
    final Map<String, String> branchMap = {
      'CE': 'Civil Engineering',
      'CS': 'Computer Science and Engineering',
      'ME': 'Mechanical Engineering',
      'EC': 'Electronics and Communication Engineering',
      'BT': 'Biotechnology',
      'CH': 'Chemical Engineering',
      'PE': 'Production Engineering',
      'MS': 'Material Science and Engineering',
      'EE': 'Electrical and Electronics Engineering',
    };
    return branchMap[branchCode.toUpperCase()] ?? 'Unknown Branch';
  }

  //getters for relations
  static String get courseRelation =>
      (role == Role.faculty) ? "Courses Offered" : "Enrolled Courses";

  static String get idRelation =>
      (role == Role.faculty) ? "Identifier    " : "RegNo           ";
}

class CourseData {
  static List<String> allcourses = [
    "Compiler Design",
    "Computer Networks",
    "Data Structures and Algorithms",
    "Database Management Systems",
    "Design and Analysis of Algorithms",
    "Artificial Intelligence",
    "Machine Learning",
    "Program Design",
  ];

  static void getCourses() {
    //TODO Implement getCourses();
  }

  static void clearCourses() {
    allcourses = [];
  }
}

class FacultyData {
  static List<String> allFaculties = [
    "Hiran V Nath",
    "Venkatarami Reddy Chinthapalli",
    "Priya Chandran",
    "Muralikrishnan K",
    "Jimmy Jose",
    "Vinod Pathari",
    "Anil Pinapati",
    "Muneeswaran",
    "T M Sreenivasa",
    "Nirmal Kumar Boran",
    "Jayaraj P B",
    "Saidalavi Kalady",
    "Shwetha Singh",
    "Anu Mary Chacko",
    "Manjusha",
    "T Veni",
    "Saleena Nazeer",
    "Abdul Naseer",
    "Madhu",
    "Lijiya",
    "Joe Cheri Ross",
    "Anand Babu N B",
    "R Subhashini",
    "Subhasree",
    "T A Sumesh"
    "Gopakumar G"
    "Pournami",
    "Chandramani Chaudhary",
    "Jacob MJ",
    "G Varaprasad",
    "Nehem Tudu",
  ];

  static void getFaculties() {
    //TODO Implement getFaculties()
  }
}

class SlotData {
  static List<String> allSlots = [
    "A1",
    "B1",
    "C1",
    "A2",
    "B2",
    "C2",
    "D1",
    "D2",
    "E1",
    "E2",
  ];
}
