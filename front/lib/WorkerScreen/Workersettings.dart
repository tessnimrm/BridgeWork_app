import 'package:brigdeWork_app/WorkerScreen/LikedPage.dart';
import 'package:brigdeWork_app/WorkerScreen/RequestPage.dart';
import 'package:brigdeWork_app/changepassword.dart';
import 'package:brigdeWork_app/choicepage.dart';
import 'package:brigdeWork_app/WorkerScreen/editWorkerProfile.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../background.dart';
import 'package:brigdeWork_app/WorkerScreen/bottomBarWorker.dart';
import 'package:brigdeWork_app/Routes.dart';
import 'package:brigdeWork_app/pages.dart/first_page.dart';
import 'package:provider/provider.dart';
import 'package:brigdeWork_app/providers/WorkerProvider.dart';
import 'dart:io';

class WorkerSettingsPage extends StatefulWidget {
  const WorkerSettingsPage({super.key});

  @override
  State<WorkerSettingsPage> createState() => _WorkerSettingsPageSetState();
}

class _WorkerSettingsPageSetState extends State<WorkerSettingsPage> {
  String selectedLanguage = 'French';

  @override
  Widget build(BuildContext context) {
    final workerProvider = Provider.of<WorkerProvider>(context);
    final data = workerProvider.workerData;

    // ✅ تحديد صورة البروفايل
    ImageProvider profileImage;
    if (data?.profileImagePath != null && data!.profileImagePath.isNotEmpty) {
      final file = File(data.profileImagePath);
      if (file.existsSync()) {
        profileImage = FileImage(file);
      } else {
        profileImage = const AssetImage('lib/images/photo_2.jpg');
      }
    } else {
      profileImage = const AssetImage('lib/images/photo_2.jpg');
    }

    final fullName = (data?.fullName != null && data!.fullName.isNotEmpty)
        ? data.fullName
        : 'Your Name';

    final emailOrRole = (data?.email != null && data!.email.isNotEmpty)
        ? data.email
        : 'Worker';

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: GradientBackground(
        child: Container(
          height:
              MediaQuery.of(context).size.height -
              kBottomNavigationBarHeight -
              MediaQuery.of(context).padding.top,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 71),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: profileImage,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                fullName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('UI UX DESIGN', style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 51,
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfileWorker(),
                            ),
                          );
                          setState(() {});
                        },
                        child: Card(
                          color: HexColor("#837DE1"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Edit profile",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 51,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Choicepage(),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Switch mode",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 350,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Requestpage(),
                            ),
                          );
                        },
                        child: Container(
                          height: 53,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Row(
                            children: [
                              Icon(Icons.notifications_none_outlined, size: 20),
                              SizedBox(width: 12),
                              Text("Requests", style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Likedpage(),
                            ),
                          );
                        },
                        child: Container(
                          height: 53,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Row(
                            children: [
                              Icon(Icons.favorite_border_outlined, size: 20),
                              SizedBox(width: 12),
                              Text("Liked"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 53,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Icon(Icons.language, size: 20),
                            const SizedBox(width: 12),
                            const Text(
                              "Language",
                              style: TextStyle(fontSize: 15),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                _showLanguageDialog();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: HexColor("#4F46E5").withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: HexColor("#4F46E5"),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  selectedLanguage == 'French' ? "Fr" : "En",
                                  style: TextStyle(
                                    color: HexColor("#4F46E5"),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 350,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Changepassword(),
                            ),
                          );
                        },
                        child: Container(
                          height: 53,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Row(
                            children: [
                              Icon(Icons.lock_outline, size: 20),
                              SizedBox(width: 12),
                              Text(
                                "Change password",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _showLogoutDialog,
                        child: Container(
                          height: 53,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                size: 20,
                                color: HexColor("#EB2C2C"),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "log out",
                                style: TextStyle(color: HexColor("#EB2C2C")),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, Routes.Work);
          } else if (index == 1) {
            // Navigate to messages
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, Routes.workerProfile);
          } else if (index == 3) {
            // Already on settings
          }
        },
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Log out of your account?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                final workerProvider = Provider.of<WorkerProvider>(
                  context,
                  listen: false,
                );
                workerProvider.clearProfile();

                Navigator.of(context).popUntil((route) => route.isFirst);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Realone()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor("#EB2C2C"),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Log out'),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Choose a Language',
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLanguageOption('English', setDialogState),
                  const SizedBox(height: 8),
                  _buildLanguageOption('French', setDialogState),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLanguageOption(String lang, StateSetter setDialogState) {
    bool isSelected = selectedLanguage == lang;
    return GestureDetector(
      onTap: () {
        setDialogState(() {
          selectedLanguage = lang;
        });
        setState(() {
          selectedLanguage = lang;
        });
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? HexColor("#4F46E5") : Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          title: Text(
            lang,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? HexColor("#4F46E5") : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
