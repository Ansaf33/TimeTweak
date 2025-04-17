import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_tweak/app_data.dart';
import 'package:time_tweak/main.dart';
import 'package:time_tweak/screens/home.dart';
import 'package:time_tweak/screens/student_sign_up.dart';
import 'package:time_tweak/services_and_models/models.dart';
import 'package:time_tweak/services_and_models/services.dart';
import 'package:time_tweak/widgets/error_display.dart';
import 'package:time_tweak/widgets/loading.dart';
import 'package:time_tweak/widgets/slack_animation.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static final TextEditingController _idCtrl = TextEditingController();
  static final TextEditingController _passwdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final double sw;
    final double sh;
    sw = MediaQuery.of(context).size.width;
    sh = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: sw * 0.2),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SlackLogoAnimation(sw: sw),
                  Text(
                    "Sign In",
                    style: GoogleFonts.outfit(
                      fontSize: sw * 0.11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: sh * 0.02,
                      left: sw * 0.15,
                      right: sw * 0.15,
                    ),
                    child: TextFormField(
                      controller: _idCtrl,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                theme
                                    .onSurface, // Use the onSurface color from the theme
                            width: 3.0, // Set the border width
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ), // Rounded corners
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 3.0),
                        ),
                        hintText: "User ID",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: sh * 0.02,
                      left: sw * 0.15,
                      right: sw * 0.15,
                    ),
                    child: TextFormField(
                      controller: _passwdCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                theme
                                    .onSurface, // Use the onSurface color from the theme
                            width: 3.0, // Set the border width
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ), // Rounded corners
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 3.0),
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: sw * 0.04,
                      // left: sw * 0.05,
                      // right: sw * 0.05,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(
                            horizontal: sw * 0.09,
                            vertical: sw * 0.015,
                          ),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          theme.onSurface,
                        ),
                      ),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: sw * 0.06,
                          color: theme.surface,
                        ),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _signIn(_idCtrl.text, _passwdCtrl.text);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: sh * 0.07),
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: sw * 0.05),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: sw * 0.04,
                      // left: sw * 0.05,
                      // right: sw * 0.05,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(
                            horizontal: sw * 0.09,
                            vertical: sw * 0.015,
                          ),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(width: 2),
                          ),
                        ),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: sw * 0.05),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signIn(String id, String passwd) async {
    Loading.show();
    try {
      final RegExp rollnum = RegExp(
        r'^[BMP]2\d{5}(?:CS|EC|EE|ME|PE|EP|MT|CE|AR|CH|BT)$',
      );
      //Hash passwd
      //final String passHash = Utilities.sha256Hash(passwd);//TODO Enable this
      final String passHash = passwd;
      if (rollnum.hasMatch(id)) {
        if (CRData.allCRs.any((c) => c.regNo == id)) {
          final (res, msg) = await ClassRepService.fetch(regNo: id);

          if (res) {
            ClassRep data = ClassRep.fromJson(msg);
            if (passHash == data.password) {
              data.setAsCurrentUserData();
              await TimetableService.getAll();
              Loading.close();
              final BuildContext? context = navigatorKey.currentContext;
              if (context == null) {
                throw Exception("Context not available for SignIn");
              }
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (ctx) => MainSchedule()),
                (route) => false,
              );
              return;
            }
            return ErrorDisplay.showSnackBar(
              "UserId and password doesn't match",
            );
          }
          return ErrorDisplay.showSnackBar(msg.toString());
        } else {
          final (res, msg) = await StudentService.fetch(regNo: id);

          if (res) {
            Student data = Student.fromJson(msg);
            if (passHash == data.password) {
              data.setAsCurrentUserData();
              await TimetableService.getAll();
              Loading.close();
              final BuildContext? context = navigatorKey.currentContext;
              if (context == null) {
                throw Exception("Context not available for SignIn");
              }
              if (!context.mounted) {
                throw Exception("context unmounted before pop");
              }
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (ctx) => MainSchedule()),
                (route) => false,
              );
              return;
            }
            return ErrorDisplay.showSnackBar(
              "UserId and password doesn't match",
            );
          }
          return ErrorDisplay.showSnackBar(msg.toString());
        }
      } else {
        final (res, msg) = await FacultyService.fetch(facId: id);
        if (res) {
          Faculty data = Faculty.fromJson(msg);
          if (passHash == data.password) {
            data.setAsCurrentUserData();
            await TimetableService.getAll();
            Loading.close();
            final BuildContext? context = navigatorKey.currentContext;
            if (context == null) {
              throw Exception("Context not available for SignIn");
            }
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (ctx) => MainSchedule()),
              (route) => false,
            );
            return;
          }
          return ErrorDisplay.showSnackBar("UserId and password doesn't match");
        }
        return ErrorDisplay.showSnackBar(msg.toString());
      }
    } finally {
      _idCtrl.clear();
      _passwdCtrl.clear();
      Loading.close();
    }
  }
}
