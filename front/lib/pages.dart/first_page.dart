import './signup_page.dart';
import 'package:flutter/material.dart';
import '../widgets/button.dart';
import '../widgets/background.dart';
import 'login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CompanyScreen/main_pagehire.dart';

class Realone extends StatelessWidget {
  const Realone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GradientBackground(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  const Spacer(flex: 2),
                  const Paragraph(),
                  const Spacer(flex: 1),
                  Flexible(
                    flex: 4,
                    child: Image.asset(
                      'lib/images/3022e377fdbaa43092e09875017df8743cf60e4c.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Spacer(flex: 1),
                  Botton(
                    text: "Create account",
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Signup()),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: Text(
                      'Log in',
                      style: GoogleFonts.inter(
                        color: const Color.fromRGBO(79, 70, 229, 100),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                  /*
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                           builder: (context) => const Hire(name: "Hello !"),
                        ),
                      );
                    },
                    child: Text(
                      'Continue as a guest',
                      style: GoogleFonts.inter(
                        color: const Color.fromARGB(255, 114, 120, 134),
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  */
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class Paragraph extends StatelessWidget {
  const Paragraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      width: 287,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Work today,',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.black,
            ),
          ),
          Text(
            'Hire tomorrow.',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Color.fromRGBO(79, 70, 229, 100),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'switch between finding work and hiring\npeople - anytime',
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(color: Color.fromARGB(255, 71, 68, 72)),
          ),
        ],
      ),
    );
  }
}
