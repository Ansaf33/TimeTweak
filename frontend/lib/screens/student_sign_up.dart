import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_tweak/app_data.dart';
import 'package:time_tweak/main.dart';
import 'package:time_tweak/screens/admin_auth.dart';
import 'package:time_tweak/screens/course_selection.dart';
import 'package:time_tweak/screens/sign_in.dart';
import 'package:time_tweak/services_and_models/models.dart';
import 'package:time_tweak/services_and_models/services.dart';
import 'package:time_tweak/services_and_models/utils.dart';
import 'package:time_tweak/widgets/error_display.dart';
import 'package:time_tweak/widgets/loading.dart';
import 'package:time_tweak/widgets/slack_animation.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController _usrnameCtrl = TextEditingController();
  final TextEditingController _rollNumCtrl = TextEditingController();
  final TextEditingController _passwdCtrl = TextEditingController();
  final ValueNotifier<bool> _isPasswordHidden = ValueNotifier(true);
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
            padding: EdgeInsets.symmetric(vertical: sh * 0.02),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SlackLogoAnimation(sw: sw),
                  Text(
                    "Create Account",
                    style: GoogleFonts.outfit(
                      fontSize: sw * 0.1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "(Student)",
                    style: GoogleFonts.outfit(
                      fontSize: sw * 0.05,
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
                      controller: _usrnameCtrl,
                      style: GoogleFonts.bubblegumSans(),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: sw * 0.02,
                          horizontal: sw * 0.04,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: theme.onSurface,
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
                        hintText: "Full Name",
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
                      controller: _rollNumCtrl,
                      textCapitalization: TextCapitalization.characters,
                      style: GoogleFonts.bubblegumSans(),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: sw * 0.02,
                          horizontal: sw * 0.04,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: theme.onSurface,
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
                        hintText: "Register No",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: sh * 0.02,
                      left: sw * 0.15,
                      right: sw * 0.15,
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: _isPasswordHidden,
                      builder: (context, value, child) {
                        return TextFormField(
                          controller: _passwdCtrl,
                          style: GoogleFonts.bubblegumSans(),
                          obscureText: value,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: sw * 0.02,
                              horizontal: sw * 0.04,
                            ),
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
                            suffixIcon: GestureDetector(
                              onTap:
                                  () =>
                                      _isPasswordHidden.value =
                                          !_isPasswordHidden.value,
                              child: _getPwdIcon(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: sh * 0.015),
                    child: BatchChoice(sw: sw),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: sw * 0.07),
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
                        "Sign Up",
                        style: TextStyle(
                          fontSize: sw * 0.06,
                          color: theme.surface,
                        ),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        _verifyValues(
                          _usrnameCtrl.text,
                          _rollNumCtrl.text.toUpperCase(),
                          _passwdCtrl.text,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: sh * 0.07),
                    child: Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: sw * 0.045),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: sw * 0.02,
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
                        "Sign In",

                        style: TextStyle(fontSize: sw * 0.04),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: sw * 0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Faculty or CR? ",
                          style: TextStyle(fontSize: sw * 0.04),
                        ),
                        GestureDetector(
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminAuth(sw: sw),
                                ),
                              ),
                          child: Text(
                            "Register now",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: sw * 0.04,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
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

  Icon _getPwdIcon() {
    return _isPasswordHidden.value
        ? Icon(Icons.visibility_outlined)
        : Icon(Icons.visibility_off_outlined);
  }

  _verifyValues(String username, String rollnum, String passwd) async {
    Loading.show();
    try {
      if (username.trim() == "") {
        return ErrorDisplay.showSnackBar('Username cannot be empty');
      }

      final rollRegex = RegExp(
        r'^[BMP]2\d{5}(?:CS|EC|EE|ME|PE|EP|MT|CE|AR|CH|BT)$',
      );
      if (!rollRegex.hasMatch(rollnum)) {
        return ErrorDisplay.showSnackBar('Invalid roll number format.');
      }

      if (passwd.isEmpty || passwd.length < 6) {
        return ErrorDisplay.showSnackBar(
          'Password must be at least 6 characters.',
        );
      }

      passwd = Utilities.sha256Hash(passwd.trim());
      final (res, msg) = await StudentService.newStudent(
        //Calling Service
        studentData:
            Student(
              regNo: rollnum,
              batch: BatchChoice.selectedOption,
              name: username,
              password: passwd,
            ).toJson(),
      );

      if (!res) {
        return ErrorDisplay.showSnackBar(msg);
      } else {
        final (res, msg) = await StudentService.fetch(regNo: rollnum);
        if (!res) {
          return ErrorDisplay.showSnackBar(msg);
        }
        Student.fromJson(msg).setAsCurrentUserData();
        Loading.close();
        final BuildContext? navContext = navigatorKey.currentContext;
        if (navContext == null) {
          throw Exception("Context not available for CourseSelection page");
        }
        if (navContext.mounted) {
          return Navigator.push(
            navContext,
            MaterialPageRoute(
              builder: (ctx) => CourseSelectionScreen(isSignUp: true),
            ),
          );
        }
      }
    } finally {
      Loading.close();
    }
  }
}

class BatchChoice extends StatelessWidget {
  BatchChoice({super.key, required this.sw});

  final double sw;
  static Batch selectedOption = Batch.morning;
  final ValueNotifier<Batch> _notifier = ValueNotifier(Batch.morning);

  void _update(Batch value) {
    selectedOption = value;
    _notifier.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _notifier,
      builder:
          (context, value, _) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _update(Batch.morning),
                child: Text("Morning"),
              ),
              Radio(
                value: Batch.morning,
                groupValue: selectedOption,
                onChanged: (value) => _update(Batch.morning),
              ),
              SizedBox(width: sw * 0.05),

              Radio(
                value: Batch.afternoon,
                groupValue: selectedOption,
                onChanged: (value) => _update(Batch.afternoon),
              ),
              GestureDetector(
                onTap: () => _update(Batch.afternoon),
                child: Text("Evening"),
              ),
            ],
          ),
    );
  }
}
