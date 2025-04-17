import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:time_tweak/app_data.dart';
import 'package:time_tweak/services_and_models/models.dart';

class Utilities {
  static String sha256Hash(String input) {
    final bytes = utf8.encode(input); // Convert string to bytes
    final digest = sha256.convert(bytes); // Compute SHA-256 hash
    return digest.toString(); // Convert hash to hex string
  }

  static bool isCourseHappeningOnDate(Course? course, String date) {
    if (course == null) return true;
    return course.timings.any(
      (entry) => entry.date == date && entry.active == true,
    );
  }

  static List<String> getCourseSlotsOnDate(Course course, String date) {
    return course.timings
        .where((entry) => entry.date == date)
        .map((entry) => SlotData.getSlotFromIndex(entry.slotIdentifier))
        .toList();
  }

  static List<String> getSlotsForCourseOnDate(Course course, String date) {
    return course.timings
        .where((entry) => entry.date == date && entry.active)
        .map((entry) => SlotData.getSlotFromIndex(entry.slotIdentifier))
        .toList();
  }

  static List<Faculty> getFacultiesbyCourse(Course? course) {
    if (course == null) return FacultyData.allFaculties;
    return FacultyData.allFaculties
        .where(
          (faculty) =>
              faculty.courses.any((c) => c.courseId == course.courseId),
        )
        .toList();
  }
}

class Rebuild {
  static final ValueNotifier<bool> ec = ValueNotifier(false);
  static final ValueNotifier<bool> apps = ValueNotifier(false);
  static final ValueNotifier<bool> resc = ValueNotifier(false);
  static final ValueNotifier<bool> reqs = ValueNotifier(false);
  static final ValueNotifier<bool> tt = ValueNotifier(false);
  static enrolledCourses() {
    ec.value = !ec.value;
  }

  static appointments() {
    apps.value = !apps.value;
  }

  static reschedules() {
    resc.value = !resc.value;
  }

  static requests() {
    reqs.value = !reqs.value;
  }

  static timetables() {
    tt.value = !tt.value;
  }
}
