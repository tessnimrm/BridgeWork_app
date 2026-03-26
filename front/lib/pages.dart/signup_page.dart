import 'package:brigdeWork_app/pages.dart/login_page.dart';
import 'package:flutter/material.dart';
import '../widgets/background.dart';
import '../widgets/input.dart';
import '../widgets/button.dart';
import '../widgets/simplebutton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brigdeWork_app/choicepage.dart';
import 'package:provider/provider.dart';
import '../providers/WorkerProvider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    if (fullNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your full name'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      );
      return false;
    }

    if (emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email or phone number'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      );
      return false;
    }

    if (passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your password'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GradientBackground(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Spacer(flex: 1),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const BackButton(),
                            const SizedBox(width: 30),
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
                        const Spacer(flex: 1),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Input(
                              text: "Full name",
                              obscureText: false,
                              controller: fullNameController,
                            ),
                            const SizedBox(height: 10),
                            Input(
                              text: "Email / Phone number",
                              obscureText: false,
                              controller: emailController,
                            ),
                            const SizedBox(height: 14),
                            Input(
                              text: "Password",
                              obscureText: true,
                              controller: passwordController,
                            ),
                            const SizedBox(height: 50),
                            Botton(
                              text: "Create account",
                              onPressed: () {
                                if (_validateInputs()) {
                                  final workerProvider =
                                      Provider.of<WorkerProvider>(
                                        context,
                                        listen: false,
                                      );

                                  workerProvider.createProfile(
                                    selectedWork: [],
                                    selectedAvailability: [],
                                    selectedLanguages: [],
                                    customSkills: [],
                                    customLanguages: [],
                                    fullName: fullNameController.text.trim(),
                                    email: emailController.text.trim(),
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Choicepage(),
                                    ),
                                  );
                                }
                              },
                              textColor: const Color.fromARGB(
                                255,
                                255,
                                255,
                                255,
                              ),
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: 345,
                              child: Divider(
                                color: const Color.fromARGB(255, 106, 103, 103),
                                thickness: 2,
                              ),
                            ),
                            const SizedBox(height: 30),

                            Bottonsimple(
                              text: "Continue with google",
                              onPressed: () {},
                            ),
                            const SizedBox(height: 30),
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
                                const SizedBox(width: 5),
                                Text(
                                  "or",
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 78, 77, 77),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: 154,
                                  child: Divider(
                                    color: Color.fromARGB(255, 95, 93, 93),
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account ?",
                                  style: GoogleFonts.inter(
                                    color: const Color.fromARGB(
                                      255,
                                      91,
                                      89,
                                      89,
                                    ),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                GestureDetector(
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
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        const Spacer(flex: 1),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
