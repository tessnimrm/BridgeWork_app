import 'package:careermatch_app/choicepage.dart';
import 'package:careermatch_app/background.dart';
//import 'package:careermatch_app/home.dart'; // أضف هذا
import 'package:careermatch_app/message.dart'; // أضف هذا
import 'package:careermatch_app/profileWorker.dart'; // أضف هذا
//import 'package:careermatch_app/settings.dart'; // أضف هذا
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
      // home: GradientBackground(child: Choicepage()), // 👈 عطل هذه

      // 👇 استخدم initialRoute بدل home
      initialRoute: '/',

      // 👇 أضف routes هنا
      routes: {
        '/': (context) => GradientBackground(child: Choicepage()),
        //'/home': (context) => const HomePage(),
        '/messages': (context) =>
            const MessagePage(), // تأكد من اسم الصفحة MessagePage
        //'/profile': (context) => const ProfilePage(),
        //'/settings': (context) => const SettingsPage(),
      },
    );
  }
}
