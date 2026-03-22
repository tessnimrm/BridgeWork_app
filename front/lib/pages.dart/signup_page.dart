import 'package:brigdeWork_app/pages.dart/login_page.dart';
import 'package:flutter/material.dart';
import '../widgets/background.dart';
import '../widgets/input.dart';
import '../widgets/button.dart';
import '../widgets/simplebutton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brigdeWork_app/choicepage.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController fullNameController = TextEditingController();
  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: GradientBackground(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 70),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      BackButton(),
                      SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create your account",
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              shadows: const <Shadow>[
                                Shadow(
                                  offset: Offset(3, 3),
                                  blurRadius: 5.0,
                                  color: Color.fromARGB(137, 100, 98, 98),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "It only takes a minute",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(144, 141, 141, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Input(
                        text: "Full name",
                        obscureText: false,
                        controller: fullNameController,
                      ),
                      SizedBox(height: 10),
                      Input(text: "Email / Phone number", obscureText: false),
                      SizedBox(height: 14),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Input(text: "Password", obscureText: true),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      Botton(
                        text: "Create account",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Choicepage(),
                            ),
                          );
                        },
                        textColor: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                        width: 345,
                        child: Divider(
                          color: const Color.fromARGB(255, 106, 103, 103),
                          thickness: 2,
                        ),
                      ),
                      SizedBox(height: 30),
                      Bottonsimple(
                        text: "Continue with apple",
                        onPressed: () {},
                      ),
                      SizedBox(height: 10),
                      Bottonsimple(
                        text: "Continue with google",
                        onPressed: () {},
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 154,
                            child: Divider(
                              color: Color.fromARGB(255, 96, 95, 95),
                              thickness: 2,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "or",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 78, 77, 77),
                            ),
                          ),
                          SizedBox(width: 5),
                          SizedBox(
                            width: 154,
                            child: Divider(
                              color: Color.fromARGB(255, 95, 93, 93),
                              thickness: 2,
                            ),
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account ?",
                            style: GoogleFonts.inter(
                              color: const Color.fromARGB(255, 91, 89, 89),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              },
                              child: Text(
                                " Log in",
                                style: GoogleFonts.inter(
                                  color: Color.fromRGBO(79, 70, 229, 100),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
