import 'package:flutter/material.dart';
import 'package:github_square/core/services/service_locator.dart';
import 'package:github_square/presentation/screens/home_screen.dart';
import 'package:github_square/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Github Square',
      home: SplashScreen(),
    );
  }
}
