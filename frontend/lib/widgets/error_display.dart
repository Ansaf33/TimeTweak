import 'package:flutter/material.dart';
import 'package:time_tweak/main.dart';

class ErrorDisplay {
  static void showSnackBar(String message) {
    final BuildContext? context = navigatorKey.currentContext;
    if (context == null) {
      throw Exception("Context not available");
    }
    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.report_gmailerrorred_rounded,
            color: Colors.black,
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Outfit',
                fontVariations: [FontVariation.weight(500)],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(239, 249, 109, 109),
      behavior: SnackBarBehavior.floating,
      elevation: 14,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.blueGrey),
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
