import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_tweak/app_data.dart';
import 'package:time_tweak/widgets/slack_animation.dart';

class CRSignUpScreen extends StatelessWidget {
  CRSignUpScreen({super.key});

  final ValueNotifier<bool> _isPasswordHidden = ValueNotifier(true);
  final TextEditingController usrnm = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController regno = TextEditingController();
  final TextEditingController passwd = TextEditingController();

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
          child: Form(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: sw * 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SlackLogoAnimation(sw: sw),
                  Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: sw * 0.1,
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
                      controller: usrnm,
                      style: GoogleFonts.bubblegumSans(),
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
                        hintText: "Username",
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
                      controller: name,
                      textCapitalization: TextCapitalization.words,
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
                      controller: regno,
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
                          controller: passwd,
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
                    padding: EdgeInsets.only(top: sw * 0.04),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: sw * 0.09),
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
                          fontSize: sw * 0.05,
                          color: theme.surface,
                        ),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
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

  Icon _getPwdIcon() {
    return _isPasswordHidden.value
        ? Icon(Icons.visibility_outlined)
        : Icon(Icons.visibility_off_outlined);
  }

  String getBranch(String regno) {   //TODO Implement models
    // Extract the last two characters (branch code)
    String branchCode = regno.substring(regno.length - 2).toUpperCase();

    // mapping of branch codes to their full names
    Map<String, String> branchMap = {
      "CS": "Computer Science and Engineering",
      "EC": "Electronics and Communication Engineering",
      "EE": "Electrical Engineering",
      "ME": "Mechanical Engineering",
      "CE": "Civil Engineering",
    };

    return branchMap[branchCode] ?? "Unknown Branch";
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
                value: Batch.evening,
                groupValue: selectedOption,
                onChanged: (value) => _update(Batch.evening),
              ),
              GestureDetector(
                onTap: () => _update(Batch.evening),
                child: Text("Evening"),
              ),
            ],
          ),
    );
  }
}
