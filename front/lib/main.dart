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
import 'package:brigdeWork_app/providers/WorkerProvider.dart';
import 'package:brigdeWork_app/providers/LikedJobsProvider.dart';
import '../providers/RequestProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WorkerProvider()),
        ChangeNotifierProvider(create: (_) => LikedJobsProvider()),
        ChangeNotifierProvider(create: (_) => RequestsProvider()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BridgeWork',
      debugShowCheckedModeBanner: false,
      initialRoute: '/firstPage',
      routes: {Routes.choicepage: (context) => const Choicepage()},
      onGenerateRoute: (settings) {
        if (settings.name == '/firstPage') {
          return MaterialPageRoute(builder: (context) => const Realone());
        }
        // صفحات العامل
        else if (settings.name == Routes.workerProfile) {
          return MaterialPageRoute(builder: (context) => const ProfileWorker());
        } else if (settings.name == Routes.workerSettings) {
          return MaterialPageRoute(
            builder: (context) => const WorkerSettingsPage(),
          );
        } else if (settings.name == Routes.workerEditProfile) {
          return MaterialPageRoute(
            builder: (context) => const EditProfileWorker(),
          );
        } else if (settings.name == Routes.Work) {
          final args = settings.arguments as Map?;
          return MaterialPageRoute(builder: (context) => Work());
        }
        // صفحات الشركة
        else if (settings.name == Routes.companyProfile) {
          return MaterialPageRoute(
            builder: (context) => const ProfileCompany(),
          );
        } else if (settings.name == Routes.companySettings) {
          return MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(child: Text('Company Settings Page')),
            ),
          );
        } else if (settings.name == Routes.companyEditProfile) {
          return MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(child: Text('Edit Company Profile Page')),
            ),
          );
        }
        return null;
      },
    );
  }
}
