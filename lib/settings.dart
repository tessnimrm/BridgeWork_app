import 'package:BrigdeWork_app/choicepage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'background.dart';
import 'package:BrigdeWork_app/bottomBar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageSetState();
}

class _SettingsPageSetState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Container(
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
                        image: AssetImage('lib/images/photo_2.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                const Text(
                  'YOUR FULL NAME',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text('UI UX DESIGNER', style: TextStyle(fontSize: 14)),

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
                          child: Card(
                            color: HexColor("#D9D9D9"),
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
                                builder: (context) => Choicepage(),
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
                          onTap: () {},
                          child: Container(
                            height: 53,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.notifications_none_outlined,
                                  size: 20,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  "Notifications",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 53,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Row(
                              children: [
                                Icon(Icons.language, size: 20),
                                SizedBox(width: 12),
                                Text("Languages"),
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {},
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
                          onTap: () {},
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
                        SizedBox(height: 53),
                        GestureDetector(
                          onTap: () {},
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
                                SizedBox(width: 12),
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

                const SizedBox(height: 30), // مسافة إضافية في النهاية
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomBar(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/messages');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          } else if (index == 3) {}
        },
      ),
    );
  }
}
