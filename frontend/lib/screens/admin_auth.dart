import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_tweak/screens/cr_sign_up.dart';
import 'package:time_tweak/screens/faculty_sign_up.dart';

class AdminAuth extends StatefulWidget {
  const AdminAuth({super.key, required this.sw});

  final double sw;

  @override
  AdminAuthState createState() => AdminAuthState();
}

class AdminAuthState extends State<AdminAuth> with TickerProviderStateMixin {
  final TextEditingController _passwordController = TextEditingController();
  bool _isError = false;
  bool _showWrongPassword = false;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  late AnimationController _blinkController;
  late Animation<Color?> _blinkAnimation;

  @override
  void initState() {
    super.initState();

    // Shake Animation
    _shakeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _shakeAnimation = Tween<double>(
      begin: 0,
      end: 10,
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController);

    // Blinking Red Animation
    _blinkController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _blinkAnimation = ColorTween(
      begin: Color.fromARGB(255, 134, 134, 134),
      end: Colors.red,
    ).animate(_blinkController);
  }

  void _checkPassword() async {
    FocusScope.of(context).unfocus();
    if (_passwordController.text == "CRL17") {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1500),
          pageBuilder:
              (_, __, ___) =>
                  SuccessScreen(sw: widget.sw, dest: Destination.cr),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } else if (_passwordController.text == "FACULTY555") {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 1500),
          pageBuilder:
              (_, __, ___) =>
                  SuccessScreen(sw: widget.sw, dest: Destination.faculty),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } else {
      setState(() {
        _isError = true;
        _showWrongPassword = true;
      });

      // Start shake animation
      _shakeController.forward(from: 0);
      _blinkController.repeat(reverse: true);

      Future.delayed(Duration(seconds: 1), () {
        _blinkController.stop();
      });

      Future.delayed(Duration(milliseconds: 1500), () {
        if (mounted) {
          setState(() {
            _showWrongPassword = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black87,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: widget.sw * 0.1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Lock Icon with Shake and Blink Effect
                Hero(
                  tag: "lock_icon",
                  child: AnimatedBuilder(
                    animation: Listenable.merge([
                      _shakeController,
                      _blinkController,
                    ]),
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          _isError ? _shakeAnimation.value - 5 : 0,
                          0,
                        ),
                        child: Icon(
                          Icons.lock,
                          size: widget.sw * 0.3,
                          color: _blinkAnimation.value,
                        ),
                      );
                    },
                  ),
                ),
      
                // Secure Login / Wrong Password Text
                Padding(
                  padding: EdgeInsets.only(bottom: widget.sw * 0.07),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      _showWrongPassword ? "Wrong Password" : "Secure Login",
                      key: ValueKey(
                        _showWrongPassword ? "Wrong Password" : "Secure Login",
                      ),
                      style: GoogleFonts.sourceCodePro(
                        fontSize: widget.sw * 0.08,
                        color:
                            _showWrongPassword
                                ? Colors.red
                                : Color.fromARGB(255, 185, 185, 185),
                      ),
                    ),
                  ),
                ),
      
                // Password Input Field
                TextField(
                  selectionControls: null,
                  enableInteractiveSelection: true,
                  controller: _passwordController,
                  cursorColor: Colors.white70,
                  style: GoogleFonts.sourceCodePro(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 185, 185, 185),
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 185, 185, 185),
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 150, 150),
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 150, 150),
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Enter AccessKey",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 185, 185, 185),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
      
                // Unlock Button
                Padding(
                  padding: EdgeInsets.only(top: widget.sw * 0.15),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 134, 134, 134),
                      ),
                    ),
                    onPressed: _checkPassword,
                    child: Text(
                      "Unlock",
                      style: GoogleFonts.sourceCodePro(
                        fontSize: widget.sw * 0.06,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum Destination { cr, faculty }

// Success Screen with Hero Animation
class SuccessScreen extends StatelessWidget {
  final Destination dest;
  final double sw;
  const SuccessScreen({super.key, required this.sw, required this.dest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Hero Animation for Lock Open Icon
            Hero(
              tag: "lock_icon",
              child: Icon(Icons.lock_open, size: sw * 0.3, color: Colors.green),
            ),

            // Access Granted Text
            Padding(
              padding: EdgeInsets.only(top: sw * 0.05),
              child: Text(
                "Access Granted",
                style: GoogleFonts.sourceCodePro(
                  fontSize: sw * 0.08,
                  color: Colors.green,
                ),
              ),
            ),

            // Auto-close after 2 seconds
            FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 2500)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (context.mounted) {
                      if (dest == Destination.faculty) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FacultySignUpScreen(),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CRSignUpScreen(),
                          ),
                        );
                      }
                    }
                  });
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
