import 'package:time_tweak/app_data.dart';

Batch _stringtoBatch(String batch) {
    switch (batch) {
      case "MORNING":
        return Batch.morning;
      default:
        return Batch.afternoon;
    }
  }

//People class is the super class Student and faculty are subclasses of people
abstract class People {
  final String name;
  final String password;
  final Role role;

  People({required this.name, required this.password, required this.role});

  Map<String, dynamic> toJson();

  void setAsCurrentUserData();
}

class Student extends People {
  Student._internal({
    required this.regNo,
    required this.branch,
    required this.batch,
    required super.name,
    required super.password,
    required super.role,
    required this.enrolled,
    required this.appointments,
  });

  factory Student({
    required String regNo,
    required Batch batch,
    required String name,
    required String password,
    List<Course> enrolled = const [],
    List<Appointment> apps = const [],
  }) {
    String branchCode = regNo.substring(regNo.length - 2).toUpperCase();

    return Student._internal(
      regNo: regNo,
      branch: branchCode,
      batch: batch,
      name: name,
      password: password,
      enrolled: enrolled,
      appointments: apps,
      role: Role.student,
    );
  }

  final String regNo;
  final String branch;
  final Batch batch;
  final List<Course> enrolled;
  final List<Appointment> appointments;

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['username'],
      password: json['password'],
      regNo: json['regNo'],
      batch: _stringtoBatch(json['batch']),
      enrolled:
          (json['enrolledCourses'] as List<dynamic>?)
              ?.map((e) => Course.fromJson(e))
              .toList() ??
          [],
      apps:
          (json['appointmentList'] as List<dynamic>?)
              ?.map((e) => Appointment.fromJson(e))
              .toList() ??
          [],
    );
  }

  @override
  Map<String, String> toJson() {
    return {
      "username": name,
      "password": password,
      "role": "STUDENT",
      "regNo": regNo,
      "branch": branch,
      "batch": batch.backendEnum,
    };
  }

  

  @override
  void setAsCurrentUserData() {
    CurrentUserData.name = name;
    CurrentUserData.passwd = password;
    CurrentUserData.rollNum = regNo;
    CurrentUserData.courses = enrolled;
    CurrentUserData.apps = appointments;
    CurrentUserData.resc = const [];
    CurrentUserData.batch = batch;
    CurrentUserData.role = Role.student;
  }
}

//Class rep is just a special case of student so it is a subclass of student
class ClassRep extends Student {
  final List<Reschedule> resc;

  ClassRep._internal({
    required super.regNo,
    required super.name,
    required super.password,
    required super.branch,
    required super.batch,
    required super.appointments,
    required super.enrolled,
    required this.resc,
  }) : super._internal(role: Role.cr);

  factory ClassRep({
    required String regNo,
    required String name,
    required String password,
    required Batch batch,
    List<Course> enrolled = const [],
    List<Appointment> apps = const [],
    List<Reschedule> resc = const [],
  }) {
    return ClassRep._internal(
      regNo: regNo,
      name: name,
      password: password,
      branch: regNo.substring(regNo.length - 2).toUpperCase(),
      batch: batch,
      enrolled: enrolled,
      appointments: apps,
      resc: resc,
    );
  }

  factory ClassRep.fromJson(Map<String, dynamic> json) {
    return ClassRep(
      regNo: json['regNo'],
      name: json['username'],
      password: json['password'],
      batch: _stringtoBatch(json['batch']),
      enrolled:
          (json['enrolledCourses'] as List<dynamic>?)
              ?.map((e) => Course.fromJson(e))
              .toList() ??
          [],
      apps:
          (json['appointmentList'] as List<dynamic>?)
              ?.map((e) => Appointment.fromJson(e))
              .toList() ??
          [],
      resc:
          (json['requests'] as List<dynamic>?)
              ?.map((e) => Reschedule.fromJson(e))
              .toList() ??
          [],
    );
  }

  @override
  Map<String, String> toJson() {
    return {
      "username": name,
      "password": password,
      "role": "CLASS_REP",
      "regNo": regNo,
      "branch": branch,
      "batch": batch.backendEnum,
    };
  }

  @override
  void setAsCurrentUserData() {
    CurrentUserData.name = name;
    CurrentUserData.passwd = password;
    CurrentUserData.rollNum = regNo;
    CurrentUserData.courses = enrolled;
    CurrentUserData.apps = appointments;
    CurrentUserData.resc = resc;
    CurrentUserData.batch = batch;
    CurrentUserData.role = Role.cr;
  }
}

class Course {
  Course({required this.courseId, required this.title, required this.timings});

  final String courseId;
  final String title;
  final List<TimeTableEntry> timings;

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json["courseId"],
      title: json["title"],
      timings:
          (json["timeTableEntries"] as List<dynamic>?)
              ?.map((e) => TimeTableEntry.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {"courseId": courseId, "title": title, "timeTableEntries": timings};
  }
}

class Appointment {
  Appointment({
    required this.appId,
    required this.date,
    required this.clientName,
    required this.clientId,
    required this.recipientId,
    required this.status,
    required this.reason,
    required this.slot,
  });

  final String appId;
  final String date;
  final String clientName;
  final String clientId;
  final String recipientId;
  final Status status;
  final String reason;
  final int slot;

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appId: json['appId'],
      date: json['date'],
      clientId: json['clientIdentifier'],
      clientName: json['clientName'],
      recipientId: json['recipientIdentifier'],
      status: stringToStatus(json['status']),
      reason: json['reason'],
      slot: json['slot'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "clientIdentifier": clientId,
      "recipientIdentifier": recipientId,
      "status": status.backendEnum,
      "reason": reason,
      "slot": slot,
    };
  }

  static Status stringToStatus(String status) {
    switch (status) {
      case "APPROVED":
        return Status.approved;
      case "REJECTED":
        return Status.rejected;
      default:
        return Status.pending;
    }
  }
}

class Reschedule {
  Reschedule({
    required this.rescId,
    required this.ogDate,
    required this.ogSlotIdentifier,
    required this.newDate,
    required this.newSlotIdentifier,
    required this.reason,
    required this.courseIdentifier,
    required this.crIdentifier,
    required this.facultyIdentifier,
    required this.status,
  });
  final String rescId;
  final String ogDate;
  final int ogSlotIdentifier;
  final String newDate;
  final int newSlotIdentifier;
  final String reason;
  final String courseIdentifier;
  final String crIdentifier;
  final String facultyIdentifier;
  final Status status;

  factory Reschedule.fromJson(Map<String, dynamic> json) {
    return Reschedule(
      rescId: json['rescheduleId'],
      ogDate: json['ogDate'],
      ogSlotIdentifier: json['ogSlotIdentifier'],
      newDate: json['newDate'],
      newSlotIdentifier: json['newSlotIdentifier'],
      reason: json['reason'],
      courseIdentifier: json["courseIdentifier"],
      crIdentifier: json["crIdentifier"],
      facultyIdentifier: json["facultyIdentifier"],
      status: Appointment.stringToStatus(json["status"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ogDate": ogDate,
      "ogSlotIdentifier": ogSlotIdentifier,
      "newDate": newDate,
      "newSlotIdentifier": newSlotIdentifier,
      "reason": reason,
      "crIdentifier": crIdentifier,
      "facultyIdentifier": facultyIdentifier,
      "status": status.backendEnum,
    };
  }
}

class Faculty extends People {
  Faculty({
    required this.facId,
    required super.name,
    required super.password,
    this.courses = const [],
    this.appointments = const [],
    this.reschedules = const [],
  }) : super(role: Role.faculty);

  final String facId;
  final List<Course> courses;
  final List<Appointment> appointments;
  final List<Reschedule> reschedules;

  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      facId: json['facultyId'],
      name: json['username'],
      password: json['password'],
      courses:
          (json['courseList'] as List<dynamic>?)
              ?.map((e) => Course.fromJson(e))
              .toList() ??
          [],
      appointments:
          (json['appointmentList'] as List<dynamic>?)
              ?.map((e) => Appointment.fromJson(e))
              .toList() ??
          [],
      reschedules:
          (json['rescheduleList'] as List<dynamic>?)
              ?.map((e) => Reschedule.fromJson(e))
              .toList() ??
          [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "username": name,
      "password": password,
      "role": "FACULTY",
      "facultyId": facId,
    };
  }

  @override
  void setAsCurrentUserData() {
    CurrentUserData.name = name;
    CurrentUserData.passwd = password;
    CurrentUserData.rollNum = facId;
    CurrentUserData.courses = courses;
    CurrentUserData.apps = appointments;
    CurrentUserData.resc = reschedules;
    CurrentUserData.batch = Batch.morning;
    CurrentUserData.role = Role.faculty;
  }
}

class TimeTableEntry {
  final int slotIdentifier;
  final String courseIdentifier;
  final String date;
  final bool active;
  final String type;
  final String branch;
  final Batch batch;

  TimeTableEntry({
    required this.slotIdentifier,
    required this.courseIdentifier,
    required this.date,
    required this.active,
    required this.type,
    required this.branch,
    required this.batch,
  });

  factory TimeTableEntry.fromJson(Map<String, dynamic> json) {
    return TimeTableEntry(
      slotIdentifier: json['slotIdentifier'],
      courseIdentifier: json['courseIdentifier'],
      date: json['date'],
      active: json['active'] as bool,
      type: json['type'],
      branch: json['branch'],
      batch:_stringtoBatch(json['batch']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slotIdentifier': slotIdentifier,
      'courseIdentifier': courseIdentifier,
      'date': date,
      'active': active.toString(),
      'type': type,
      'branch': branch,
      'batch': batch.backendEnum,
    };
  }
}
