import 'package:BrigdeWork_app/choicepage.dart';
import 'package:BrigdeWork_app/background.dart';
//import 'package:BrigdeWork_app/home.dart'; // أضف هذا
import 'package:BrigdeWork_app/message.dart'; // أضف هذا
//import 'package:BrigdeWork_app/profileWorker.dart'; // أضف هذا
import 'package:BrigdeWork_app/settings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => GradientBackground(child: Choicepage()),
        //'/home': (context) => const HomePage(),
        '/messages': (context) =>
            const MessagePage(), // تأكد من اسم الصفحة MessagePage
        //'/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
