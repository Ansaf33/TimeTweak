import 'package:flutter/material.dart';
class CopyRightInfo extends StatelessWidget {
  const CopyRightInfo({
    super.key,
    required this.sh,
  });

  final double sh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: sh * 0.03, bottom: sh * 0.01),
        child: Text(
          "© 2025 TimeTweak",
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontVariations: [FontVariation.weight(400)],
          ),
        ),
      ),
    );
  }
}