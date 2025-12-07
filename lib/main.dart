import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lovexl/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

   // Lock to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const Lovexl());
}

class Lovexl extends StatelessWidget {
  const Lovexl({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // This allows automatic screen tracking
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],

      home: const HomePage(),
    );
  }
}
