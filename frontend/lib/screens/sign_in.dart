import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_tweak/screens/sign_up.dart';
import 'package:time_tweak/widgets/slack_animation.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
}

