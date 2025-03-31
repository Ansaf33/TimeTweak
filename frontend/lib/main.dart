import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:time_tweak/defaults.dart';
import 'package:time_tweak/screens/home.dart';
import 'package:time_tweak/screens/requests.dart';


final ValueNotifier<ThemeMode> themeCtrl = ValueNotifier(ThemeMode.light);

void main() {
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(TimeTweak());
}

class TimeTweak extends StatelessWidget {
  const TimeTweak({super.key});

  

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeCtrl,
      builder: (context, value, _) => MaterialApp(
        title: 'TimeTweak',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: value,
        home: MainSchedule(),
      ),
    );
  }
}
