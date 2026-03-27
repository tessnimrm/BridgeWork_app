import 'package:brigdeWork_app/CompanyScreen/editCompanyProfile.dart';
import 'package:brigdeWork_app/CompanyScreen/bottomBarCompany.dart';
import 'package:brigdeWork_app/shared_pages/changepassword.dart';
import 'package:brigdeWork_app/shared_pages/choicepage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../shared_pages/background.dart';
import 'package:brigdeWork_app/shared_pages/Routes.dart';
import 'package:brigdeWork_app/shared_pages/first_page.dart';
import 'package:provider/provider.dart';
import 'package:brigdeWork_app/providers/CompanyProvider.dart';
import 'dart:io';
import 'package:brigdeWork_app/CompanyScreen/LikedPageCompany.dart';
import 'package:brigdeWork_app/CompanyScreen/RequestCompany.dart';

class CompanySettingsPage extends StatefulWidget {
  const CompanySettingsPage({super.key});

  @override
  State<CompanySettingsPage> createState() => _CompanySettingsPageState();
}

class _CompanySettingsPageState extends State<CompanySettingsPage> {
  String selectedLanguage = 'French';

  @override
  Widget build(BuildContext context) {
    final companyProvider = Provider.of<CompanyProvider>(context);
    final data = companyProvider.companyData;

    // تحديد صورة الشعار
    ImageProvider logoImage;
    if (data?.logoImagePath != null && data!.logoImagePath.isNotEmpty) {
      final file = File(data.logoImagePath);
      if (file.existsSync()) {
        logoImage = FileImage(file);
      } else {
        logoImage = const AssetImage('lib/images/photo_1.jpg');
      }
    } else {
      logoImage = const AssetImage('lib/images/photo_2.jpg');
    }

    final companyName =
        (data?.companyName != null && data!.companyName.isNotEmpty)
        ? data.companyName
        : 'Company Name';

    final industry =
        (data?.selectedIndustry != null && data!.selectedIndustry.isNotEmpty)
        ? data.selectedIndustry
        : '';

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
                    image: DecorationImage(image: logoImage, fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                companyName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (industry.isNotEmpty)
                Text(
                  industry,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
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
                              builder: (context) => const EditCompanyProfile(),
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
                              builder: (context) => const RequestPageCompany(),
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
                              builder: (context) => const LikedPageCompany(),
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
                                "Log out",
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
      bottomNavigationBar: CustomBottomBarCompany(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, Routes.Hire);
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, Routes.MessagesPage);
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, Routes.companyProfile);
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
                final companyProvider = Provider.of<CompanyProvider>(
                  context,
                  listen: false,
                );
                companyProvider.clearProfile();

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
