import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:time_tweak/app_data.dart';
import 'package:time_tweak/main.dart';
import 'package:time_tweak/services_and_models/models.dart';
import 'package:time_tweak/widgets/error_display.dart';

final String _baseURL = "http://127.0.0.1:8080";

const Duration _timeout = Duration(seconds: 60);

Future<bool> _checkConnection() async {
  try {
    final response = await http
        .head(Uri.parse('https://www.google.com'))
        .timeout(const Duration(seconds: 10));

    return response.statusCode == 200;
  } catch (_) {
    return false;
  }
}

//=============================================================================================== STUDENT SERVICES
class StudentService {
  static Future<(bool, dynamic)> fetch({required String regNo}) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      return (false, "No Internet Connection");
    }
    // Function begins here
    final res = await http
        .get(Uri.parse('$_baseURL/student/reg/$regNo'))
        .timeout(_timeout);
    if (res.statusCode == 200 && res.body.isNotEmpty) {
      return (true, jsonDecode(res.body));
    }
    return (false, "UserId and password doesn't match :(");
  }

  static Future<(bool, String)> newStudent({
    //=================checked
    required Map<String, dynamic> studentData,
  }) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      return (false, "No Internet Connection");
    }
    // Function begins here
    final res = await http
        .post(
          Uri.parse('$_baseURL/student/add'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(studentData),
        )
        .timeout(_timeout);
    if (res.statusCode == 200) {
      return (true, "success");
    } else if (res.statusCode == 404) {
      return (false, "Account already exists!");
    }
    return (false, "Something went wrong");
  }

  static Future<List<Course>?> enrolled({required String regNo}) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null) {
        throw Exception("Context not available");
      }
      if (context.mounted) {
        ErrorDisplay.showSnackBar("No Internet Connection");
      }
      return null;
    }
    // Function begins here
    final res = await http
        .get(Uri.parse('$_baseURL/student/reg/$regNo/courses/all'))
        .timeout(_timeout);
    if (res.statusCode == 200) {
      final List<Course> list = [];
      final List<dynamic> body = jsonDecode(res.body);
      for (dynamic element in body) {
        list.add(Course.fromJson(element));
      }
      return list;
    }
    return [];
  }

  static Future<(bool, String)> addCourse({
    required String regNo,
    required String courseId,
  }) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      return (false, "No Internet Connection");
    }
    // Function begins here
    final res = await http
        .post(Uri.parse('$_baseURL/student/reg/$regNo/course/add/$courseId'))
        .timeout(_timeout);
    return (res.statusCode == 200, "Something went wrong :(");
  }

  static Future<(bool, String)> removeCourse({
    required String regNo,
    required String courseId,
  }) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      return (false, "No Internet Connection");
    }
    // Function begins here
    final res = await http
        .delete(
          Uri.parse('$_baseURL/student/reg/$regNo/course/remove/$courseId'),
        )
        .timeout(_timeout);
    return (res.statusCode == 200, "Something went wrong :(");
  }

  static Future<List<Map<String, dynamic>>?> allAppointments({
    required String regNo,
  }) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null) {
        throw Exception("Context not available");
      }
      if (context.mounted) {
        ErrorDisplay.showSnackBar("No Internet Connection");
      }
    }
    // Function begins here
    final res = await http
        .get(Uri.parse('$_baseURL/student/reg/$regNo/appointments/all'))
        .timeout(_timeout);
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }

  static Future<Map<String, dynamic>?> appointmentDetails({
    required String regNo,
    required String appId,
  }) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null) {
        throw Exception("Context not available");
      }
      if (context.mounted) {
        ErrorDisplay.showSnackBar("No Internet Connection");
      }
    }
    // Function begins here
    final res = await http
        .get(Uri.parse('$_baseURL/student/reg/$regNo/appointment/$appId'))
        .timeout(_timeout);
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }

  static Future<bool> updateReason({
    required String regNo,
    required String appId,
    required String reason,
  }) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null) {
        throw Exception("Context not available");
      }
      if (context.mounted) {
        ErrorDisplay.showSnackBar("No Internet Connection");
      }
    }
    // Function begins here
    final res = await http
        .put(
          Uri.parse(
            '$_baseURL/student/reg/$regNo/appointment/$appId/update-reason',
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(reason),
        )
        .timeout(_timeout);
    return res.statusCode == 200;
  }
}

//=================================================================================================FACULTY SERVICES
class FacultyService {
  static Future<(bool, dynamic)> fetch({required String facId}) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      return (false, "No Internet Connection");
    }
    // Function begins here
    final res = await http
        .get(Uri.parse('$_baseURL/faculty/id/$facId'))
        .timeout(_timeout);
    if (res.statusCode == 200 && res.body.isNotEmpty) {
      return (true, jsonDecode(res.body));
    }
    return (false, "UserId and password doesn't match :(");
  }

  static Future<void> fetchAll() async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      ErrorDisplay.showSnackBar("No Internet Connection");
    }
    // Function begins here
    final res = await http
        .get(Uri.parse("$_baseURL/faculty/all"))
        .timeout(_timeout);

    if (res.statusCode == 200 && res.body.isNotEmpty) {
      final List<dynamic> msg = jsonDecode(res.body);
      FacultyData.allFaculties = List.generate(
        msg.length,
        (index) => Faculty.fromJson(msg[index]),
      );
    }
    return;
  }

  static Future<List<Course>?> courses({required String facID}) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null) {
        throw Exception("Context not available");
      }
      if (context.mounted) {
        ErrorDisplay.showSnackBar("No Internet Connection");
      }
      return null;
    }
    // Function begins here
    final res = await http
        .get(Uri.parse("$_baseURL/faculty/id/$facID/courses"))
        .timeout(_timeout);
    if (res.statusCode == 200) {
      final List<Course> list = [];
      final List<dynamic> body = jsonDecode(res.body);
      for (dynamic element in body) {
        list.add(Course.fromJson(element));
      }
      return list;
    }
    return [];
  }

  static Future<(bool, String)> addCourse({
    required String facId,
    required String courseId,
  }) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      return (false, "No Internet Connection");
    }
    // Function begins here
    final res = await http
        .post(Uri.parse('$_baseURL/faculty/id/$facId/course/add/$courseId'))
        .timeout(_timeout);
    return (res.statusCode == 200, "Something went wrong :(");
  }

  static Future<(bool, dynamic)> allAppointments({
    required String facId,
  }) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      return (false, "No Internet Connection");
    }
    // Function begins here
    final res = await http
        .get(Uri.parse("$_baseURL/faculty/id/$facId/appointment/all"))
        .timeout(_timeout);
    if (res.statusCode == 200) {
      final List<Appointment> list = [];
      final List<dynamic> body = jsonDecode(res.body);
      for (dynamic element in body) {
        list.add(Appointment.fromJson(element));
      }
      return (true, list);
    }
    return (false, "Something went wrong");
  }

  static Future<Map<String, dynamic>?> appointmentDetails({
    required String facId,
    required String appId,
  }) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null) {
        throw Exception("Context not available");
      }
      if (context.mounted) {
        ErrorDisplay.showSnackBar("No Internet Connection");
      }
    }
    // Function begins here
    final res = await http
        .get(Uri.parse("$_baseURL/faculty/id/$facId/appointments/$appId"))
        .timeout(_timeout);
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }

  static Future<(bool, String)> updateAppointment({
    required String facId,
    required String appId,
    required Status status,
  }) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      return (false, "No Internet Connection");
    }
    // Function begins here
    final res = await http
        .put(
          Uri.parse(
            "$_baseURL/faculty/id/$facId/appointment/$appId/to/${status.backendEnum}",
          ),
        )
        .timeout(_timeout);
    return (res.statusCode == 200, "Something went wrong");
  }

  static Future<(bool, String)> updateReschedule({
    required String facId,
    required String rescId,
    required Status status,
  }) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      return (false, "No Internet Connection");
    }
    // Function begins here
    final res = await http
        .put(
          Uri.parse(
            "$_baseURL/faculty/id/$facId/reschedule/$rescId/to/${status.backendEnum}",
          ),
        )
        .timeout(_timeout);
    return (res.statusCode == 200, "Something went wrong");
  }
}

//=====================================================================================================CLASS REP SERVICES
class ClassRepService {
  static Future<(bool, dynamic)> fetch({required String regNo}) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      return (false, "No Internet Connection");
    }
    // Function begins here
    final res = await http
        .get(Uri.parse("$_baseURL/CR/reg/$regNo"))
        .timeout(_timeout);
    if (res.statusCode == 200 && res.body.isNotEmpty) {
      return (true, jsonDecode(res.body));
    }
    return (false, "UserId and password doesn't match :(");
  }

  static Future<(bool, String)> newCR({
    //===============================Checked
    required Map<String, dynamic> crData,
  }) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      return (false, "No Internet Connection");
    }
    // Function begins here
    final res = await http
        .post(
          Uri.parse("$_baseURL/CR/add"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(crData),
        )
        .timeout(_timeout);
    if (res.statusCode == 200) {
      return (true, "success");
    } else if (res.statusCode == 404) {
      return (false, "Account already exists!");
    }
    return (false, "Something went wrong");
  }
  //==================================================================================

  static Future<void> fetchall() async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      ErrorDisplay.showSnackBar("No Internet Connection");
    }
    // Function begins here
    final res = await http.get(Uri.parse("$_baseURL/CR/all")).timeout(_timeout);
    if (res.statusCode == 200 && res.body.isNotEmpty) {
      final List<dynamic> msg = jsonDecode(res.body);
      CRData.allCRs = List.generate(
        msg.length,
        (index) => ClassRep.fromJson(msg[index]),
      );
    }
    return;
  }
}

//=====================================================================================COURSE SERVICES
class CourseService {
  static Future<bool> add({required Map<String, dynamic> courseData}) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null) {
        throw Exception("Context not available");
      }
      if (context.mounted) {
        ErrorDisplay.showSnackBar("No Internet Connection");
      }
    }
    // Function begins here
    final res = await http
        .post(
          Uri.parse('$_baseURL/course/add'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(courseData),
        )
        .timeout(_timeout);
    return res.statusCode == 200;
  }

  static Future<void> fetchAll() async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      ErrorDisplay.showSnackBar("No Internet Connection");
    }
    // Function begins here
    final res = await http
        .get(Uri.parse('$_baseURL/course/all'))
        .timeout(Duration(seconds: 30));
    if (res.statusCode == 200 && res.body.isNotEmpty) {
      final List<dynamic> msg = jsonDecode(res.body);
      CourseData.allcourses = List.generate(
        msg.length,
        (index) => Course.fromJson(msg[index]),
      );
    }
    return;
  }

  static Future<Map<String, dynamic>?> get({required String courseId}) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null) {
        throw Exception("Context not available");
      }
      if (context.mounted) {
        ErrorDisplay.showSnackBar("No Internet Connection");
      }
    }
    // Function begins here
    final res = await http
        .get(Uri.parse('$_baseURL/course/$courseId'))
        .timeout(_timeout);
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }

  static Future<List<dynamic>?> timings({required String courseId}) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null) {
        throw Exception("Context not available");
      }
      if (context.mounted) {
        ErrorDisplay.showSnackBar("No Internet Connection");
      }
    }
    // Function begins here
    final res = await http
        .get(Uri.parse('$_baseURL/course/$courseId/timing'))
        .timeout(_timeout);
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }
}

//--------------------------- APPOINTMENT SERVICES
class AppointmentService {
  static Future<List<dynamic>?> getAll() async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null) {
        throw Exception("Context not available");
      }
      if (context.mounted) {
        ErrorDisplay.showSnackBar("No Internet Connection");
        return null;
      }
    }
    // Function begins here
    final res = await http
        .get(Uri.parse('$_baseURL/appointment/all'))
        .timeout(_timeout);
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }

  static Future<List<Map<String, dynamic>>?> studentAppointments({
    required String regNo,
  }) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null) {
        throw Exception("Context not available");
      }
      if (context.mounted) {
        ErrorDisplay.showSnackBar("No Internet Connection");
        return null;
      }
    }
    // Function begins here
    final res = await http
        .get(Uri.parse('$_baseURL/appointment/student/reg/$regNo'))
        .timeout(_timeout);
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }

  static Future<List<Map<String, dynamic>>?> facultyAppointments({
    required String facId,
  }) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null) {
        throw Exception("Context not available");
      }
      if (context.mounted) {
        ErrorDisplay.showSnackBar("No Internet Connection");
        return null;
      }
    }
    // Function begins here
    final res = await http
        .get(Uri.parse('$_baseURL/appointment/faculty/reg/$facId'))
        .timeout(_timeout);
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }

  static Future<(bool, String)> add(Map<String, dynamic> appointment) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      return (false, "No Internet Connection");
    }
    // Function begins here
    final res = await http
        .post(
          Uri.parse('$_baseURL/appointment/add'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(appointment),
        )
        .timeout(_timeout);
    return (res.statusCode == 200, "Something went wrong in here");
  }

  static Future<bool> remove(String appId) async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      BuildContext? context = navigatorKey.currentContext;
      if (context == null) {
        throw Exception("Context not available");
      }
      if (context.mounted) {
        ErrorDisplay.showSnackBar("No Internet Connection");
        return false;
      }
    }
    // Function begins here
    final res = await http
        .delete(Uri.parse('$_baseURL/appointment/remove/$appId'))
        .timeout(_timeout);
    return res.statusCode == 200;
  }
}

//--------------------------- RESCHEDULE SERVICES
class RescheduleService {
  static Future<List<dynamic>?> getAll() async {
    final res = await http
        .get(Uri.parse('$_baseURL/reschedule/all'))
        .timeout(_timeout);
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }

  static Future<(bool, String)> add(Map<String, dynamic> data) async {
    final res = await http
        .post(
          Uri.parse('$_baseURL/reschedule/add'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        )
        .timeout(_timeout);
    return (res.statusCode == 200, "Error : Make sure the target slot is free");
  }

  static Future<bool> remove(String id) async {
    final res = await http
        .delete(Uri.parse('$_baseURL/reschedule/remove/$id'))
        .timeout(_timeout);
    return res.statusCode == 200;
  }

  static Future<List<Map<String, dynamic>>?> byClassRep(String regNo) async {
    final res = await http
        .get(Uri.parse('$_baseURL/reschedule/reg/$regNo'))
        .timeout(_timeout);
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }
}

//--------------------------- SLOT SERVICES
class SlotService {
  static Future<List<dynamic>?> getAll() async {
    final res = await http
        .get(Uri.parse('$_baseURL/slot/all'))
        .timeout(_timeout);
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }
}

//--------------------------- TIMETABLE SERVICES
class TimetableService {
  static Future<void> getAll() async {
    //Check Internet connection
    final check = await _checkConnection();
    if (!check) {
      return ErrorDisplay.showSnackBar("No Internet Connection");
    }
    // Function begins here
    final res = await http.get(Uri.parse('$_baseURL/tt/all')).timeout(_timeout);
    if (res.statusCode == 200 && res.body.isNotEmpty) {
      final List<dynamic> msg = jsonDecode(res.body);
      TimeTableData.tt = List.generate(
        msg.length,
        (index) => TimeTableEntry.fromJson(msg[index]),
      );
      TimeTableData.filterEntriesByCourses();
    }
    return;
  }

  static Future<List<dynamic>?> byStatus(bool isActive) async {
    final res = await http
        .get(Uri.parse('$_baseURL/tt/all/active/$isActive'))
        .timeout(_timeout);
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }

  static Future<List<dynamic>?> byBranchBatch(
    String branch,
    String batch,
  ) async {
    final res = await http
        .get(Uri.parse('$_baseURL/tt/all/$branch/$batch'))
        .timeout(_timeout);
    return res.statusCode == 200 ? jsonDecode(res.body) : null;
  }

  static Future<bool> add(Map<String, dynamic> entry) async {
    final res = await http
        .post(
          Uri.parse('$_baseURL/tt/add'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(entry),
        )
        .timeout(_timeout);
    return res.statusCode == 200;
  }

  static Future<bool> changeStatus({
    required String date,
    required int slot,
    required bool active,
  }) async {
    final res = await http
        .put(Uri.parse('$_baseURL/tt/change/date/$date/slot/$slot/$active'))
        .timeout(_timeout);
    return res.statusCode == 200;
  }

  static Future<(bool, dynamic)> freeSlots({
    required String date,
    required String branch,
    required String batch,
  }) async {
    final res = await http
        .get(
          Uri.parse(
            '$_baseURL/tt/free/slots/date/$date/branch/$branch/batch/$batch',
          ),
        )
        .timeout(_timeout);
    if (res.statusCode == 200 && res.body.isNotEmpty) {
      return (true, jsonDecode(res.body));
    }
    return (false, "UserId and password doesn't match :(");
  }
}
