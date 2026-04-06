
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/background.dart';
import '../widgets/input.dart';
import '../widgets/button.dart';
import '../widgets/simplebutton.dart';
import '../services/auth.service.dart';
import 'login_page.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (fullNameController.text.trim().isEmpty) {
      _showSnackBar('Please enter your full name');
      return false;
    }
    if (usernameController.text.trim().isEmpty) {
      _showSnackBar('Please enter a username');
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      _showSnackBar('Please enter your email');
      return false;
    }
    if (!_isValidEmail(emailController.text.trim())) {
      _showSnackBar('Please enter a valid email address');
      return false;
    }
    if (passwordController.text.trim().isEmpty) {
      _showSnackBar('Please enter your password');
      return false;
    }
    if (passwordController.text.trim().length < 6) {
      _showSnackBar('Password must be at least 6 characters');
      return false;
    }
    return true;
  }

  Future<void> _handleSignup() async {
    if (!_validateInputs()) return;
    
    setState(() => isLoading = true);
    
    try {
      final authService = AuthService();
      await authService.signup(
        email: emailController.text.trim(),
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
        fullname: fullNameController.text.trim(),
      );
      
      // Save user data to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fullName', fullNameController.text.trim());
      await prefs.setString('email', emailController.text.trim());
      await prefs.setString('username', usernameController.text.trim());
      
      _showSnackBar('Account created successfully! Please login.', isError: false);
      
      if (mounted) {
        // Clear controllers
        fullNameController.clear();
        usernameController.clear();
        emailController.clear();
        passwordController.clear();
        
        // Navigate to login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      }
    } catch (e) {
      _showSnackBar(e.toString().replaceAll('Exception: ', ''));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
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
                                    color: const Color.fromRGBO(144, 141, 141, 1),
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
                              text: "Username",
                              obscureText: false,
                              controller: usernameController,
                            ),
                            const SizedBox(height: 10),
                            Input(
                              text: "Email",
                              obscureText: false,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 14),
                            Input(
                              text: "Password",
                              obscureText: true,
                              controller: passwordController,
                            ),
                            const SizedBox(height: 50),
                            Botton(
                              text: isLoading ? "Creating account..." : "Create account",
                              onPressed: isLoading ? null : _handleSignup,
                              textColor: Colors.white,
                            ),
                            const SizedBox(height: 40),
                            const SizedBox(
                              width: 345,
                              child: Divider(
                                color: Color.fromARGB(255, 106, 103, 103),
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
                                const SizedBox(
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
                                    color: const Color.fromARGB(255, 78, 77, 77),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const SizedBox(
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
                                  "Already have an account?",
                                  style: GoogleFonts.inter(
                                    color: const Color.fromARGB(255, 91, 89, 89),
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
                                      color: const Color.fromRGBO(79, 70, 229, 100),
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
