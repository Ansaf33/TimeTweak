import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:time_tweak/main.dart';

class Loading {
  static bool isLoading = false;

  static Future<void> show() async {
    if (isLoading) return;
    isLoading = true;
    final BuildContext? context = navigatorKey.currentContext;
    if (context == null) {
      throw Exception("Context not Found. Loading.dart");
    }
    final double sw = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      barrierDismissible: false, // Disables tap-outside dismissal
      barrierColor: const Color.fromARGB(139, 255, 255, 255),
      builder: (BuildContext context) {
        return PopScope(
          canPop: false, // Prevents back button dismissal
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              width: sw * 0.7,
              height: sw * 0.7,
              child: Lottie.asset(
                fit: BoxFit.contain,
                'lib/assets/animations/loader.json',
                repeat: true,
              ),
            ),
          ),
        );
      },
    );
  }

  static void close() {
    if (!isLoading) return;
    final BuildContext? context = navigatorKey.currentContext;
    if (context == null) {
      throw Error.safeToString("Context not Found. Loading.dart");
    }
    Navigator.pop(context);
    isLoading = false;
  }

  
}
