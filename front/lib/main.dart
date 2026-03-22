import 'package:brigdeWork_app/CompanyScreen/profileCompany.dart';
import 'package:brigdeWork_app/WorkerScreen/Workersettings.dart';
import 'package:brigdeWork_app/WorkerScreen/editWorkerProfile.dart';
import 'package:brigdeWork_app/WorkerScreen/profileWorker.dart';
import 'package:brigdeWork_app/choicepage.dart';
import 'package:brigdeWork_app/background.dart';
import 'package:flutter/material.dart';
import 'package:brigdeWork_app/Routes.dart';
import 'package:brigdeWork_app/pages.dart/first_page.dart';
import 'package:brigdeWork_app/WorkerScreen/main_pagework.dart';
import 'package:provider/provider.dart';

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
      title: 'BridgeWork',
      debugShowCheckedModeBanner: false,
      initialRoute: '/firstPage',
      routes: {Routes.choicepage: (context) => Choicepage()},
      onGenerateRoute: (settings) {
        if (settings.name == '/firstPage') {
          return MaterialPageRoute(builder: (context) => const Realone());
        }
        // صفحات العامل
        else if (settings.name == Routes.workerProfile) {
          return MaterialPageRoute(builder: (context) => ProfileWorker());
        } else if (settings.name == Routes.workerSettings) {
          return MaterialPageRoute(builder: (context) => WorkerSettingsPage());
        } else if (settings.name == Routes.workerEditProfile) {
          return MaterialPageRoute(builder: (context) => EditProfileWorker());
        } else if (settings.name == Routes.Work) {
          final args = settings.arguments as Map?;
          return MaterialPageRoute(
            builder: (context) => Work(name: args?['name'] ?? 'User'),
          );
        }
        // صفحات الشركة
        else if (settings.name == Routes.companyProfile) {
          return MaterialPageRoute(builder: (context) => ProfileCompany());
        } else if (settings.name == Routes.companySettings) {
          // return MaterialPageRoute(builder: (context) => CompanySettingsPage());
        } else if (settings.name == Routes.companyEditProfile) {
          // return MaterialPageRoute(builder: (context) => EditProfileCompany());
        }
        return null;
      },
    );
  }
}
