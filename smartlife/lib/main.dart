import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartlife/pages/home_page.dart';
import 'pages/login/login_screen.dart';
import 'pages/login/register_screen.dart';
import 'pages/login/welcome_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // WidgetsFlutterBinding();
  // await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
        getPages: [
          GetPage(name: '/register', page: () => RegScreen()),
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/home', page: () => HomePage()),
        ]);
  }
}
