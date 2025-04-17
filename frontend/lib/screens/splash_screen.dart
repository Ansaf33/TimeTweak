import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:time_tweak/screens/sign_in.dart';
import 'package:time_tweak/services_and_models/services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _initRoutine(context),
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        224,
        223,
        208,
      ), // Skeuomorphic beige/paper
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Skeuomorphic-styled logo container
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: const Color(0xFFf2f0ec),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 26, 25, 25),
                    blurRadius: 30,
                  ),
                  const BoxShadow(
                    color: Color.fromARGB(255, 126, 126, 126),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Image.asset(
                'lib/assets/icons/icon_transparent.png',
                height: 80,
                width: 80,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "TimeTweak",
              style: TextStyle(fontFamily: 'Loranthus', fontSize: 40),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 120),
                  child: SizedBox(
                    height: 60,
                    child: Lottie.asset('lib/assets/animations/loader.json'),
                  ),
                ),
                Text("Initiating", style: GoogleFonts.delius()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _initRoutine(BuildContext context) async {
    await CourseService.fetchAll();
    await FacultyService.fetchAll();
    await ClassRepService.fetchall();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => SignInScreen()),
      );
    }
  }
}
