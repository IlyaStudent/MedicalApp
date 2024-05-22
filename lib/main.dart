import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_app/services/consts.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Montserrat',
          textSelectionTheme:
              const TextSelectionThemeData(selectionHandleColor: accentColor)),
      home: const SplashScreen(),
      routes: {
        '/homepage': (context) => const Home(),
      },
    );
  }
}
