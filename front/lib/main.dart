import 'package:brigdeWork_app/CompanyScreen/profileCompany.dart';
import 'package:brigdeWork_app/WorkerScreen/Workersettings.dart';
import 'package:brigdeWork_app/WorkerScreen/editWorkerProfile.dart';
import 'package:brigdeWork_app/WorkerScreen/profileWorker.dart';
import 'package:brigdeWork_app/shared_pages/choicepage.dart';
import 'package:flutter/material.dart';
import 'package:brigdeWork_app/shared_pages/Routes.dart';
import 'package:brigdeWork_app/shared_pages/first_page.dart';
import 'package:brigdeWork_app/WorkerScreen/main_pagework.dart';
import 'package:brigdeWork_app/CompanyScreen/main_pagehire.dart';
import 'package:provider/provider.dart';
import 'package:brigdeWork_app/providers/WorkerProvider.dart';
import 'package:brigdeWork_app/providers/LikedJobsProvider.dart';
import 'package:brigdeWork_app/providers/RequestProvider.dart';
import 'package:brigdeWork_app/message_page.dart';
import 'package:brigdeWork_app/providers/CompanyProvider.dart';
import 'package:brigdeWork_app/CompanyScreen/CompanySettings.dart';
import 'package:brigdeWork_app/CompanyScreen/editCompanyProfile.dart';
import 'package:brigdeWork_app/providers/UserProvider.dart';
import 'package:brigdeWork_app/providers/CompanyLiked.dart';
import 'package:brigdeWork_app/providers/CompanyRequest.dart';
import 'shared_pages/signup_page.dart';
import 'shared_pages/login_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => WorkerProvider()),
        ChangeNotifierProvider(create: (_) => CompanyProvider()),
        ChangeNotifierProvider(create: (_) => LikedJobsProvider()),
        ChangeNotifierProvider(create: (_) => RequestsProvider()),
        ChangeNotifierProvider(create: (_) => CompanyLikedWorkersProvider()),
        ChangeNotifierProvider(create: (_) => CompanyRequestsProvider()),
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
      home: const Realone(),
      routes: {
        Routes.choicepage: (context) => const Choicepage(),
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/firstPage') {
          return MaterialPageRoute(builder: (context) => const Realone());
        } else if (settings.name == Routes.MessagesPage) {
          return MaterialPageRoute(builder: (context) => const MessagesPage());
        }
        // Worker pages
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
        // Company pages
        else if (settings.name == Routes.companyProfile) {
          return MaterialPageRoute(
            builder: (context) => const ProfileCompany(),
          );
        } else if (settings.name == Routes.companySettings) {
          return MaterialPageRoute(
            builder: (context) => const CompanySettingsPage(),
          );
        } else if (settings.name == Routes.companyEditProfile) {
          return MaterialPageRoute(
            builder: (context) => const EditCompanyProfile(),
          );
        } else if (settings.name == Routes.Hire) {
          return MaterialPageRoute(builder: (context) => const Hire());
        }
        return null;
      },
    );
  }
}