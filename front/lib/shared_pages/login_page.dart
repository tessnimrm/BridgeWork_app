import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/background.dart';
import '../widgets/input.dart';
import '../widgets/button.dart';
import '../widgets/simplebutton.dart';
import '../services/auth.service.dart';
import 'signup_page.dart';
import 'choicepage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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

  Future<void> _handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    
    if (email.isEmpty) {
      _showSnackBar('Please enter your email');
      return;
    }
    
    if (password.isEmpty) {
      _showSnackBar('Please enter your password');
      return;
    }
    
    setState(() => isLoading = true);
    
    try {
      final authService = AuthService();
      final user = await authService.login(email, password);
      
      print('Login successful: $user');
      
      // Save user data to SharedPreferences (already saved in AuthService)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fullName', user['fullname']);
      await prefs.setString('email', user['email']);
      await prefs.setString('username', user['username']);
      
      if (mounted) {
        _showSnackBar('Login successful! ✅', isError: false);
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Choicepage(),
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
                  const SizedBox(height: 70),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const BackButton(),
                      const SizedBox(width: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back",
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
                            "Login to continue",
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
                  const SizedBox(height: 70),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Input(
                        text: "Email",
                        obscureText: false,
                        controller: emailController,
                      ),
                      const SizedBox(height: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Input(
                            text: "Password",
                            obscureText: obscurePassword,
                            controller: passwordController,
                          ),
                          const SizedBox(height: 7),
                          GestureDetector(
                            onTap: () {
                              _showSnackBar('Contact support to reset password');
                            },
                            child: Text(
                              "Forgot password?",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color.fromRGBO(79, 70, 229, 100),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Botton(
                        text: isLoading ? "Logging in..." : "Log in",
                        onPressed: isLoading ? null : _handleLogin,
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 40),
                      const SizedBox(
                        width: 350,
                        child: Divider(color: Colors.grey, thickness: 2),
                      ),
                      const SizedBox(height: 30),
                      Bottonsimple(
                        text: "Continue with apple",
                        onPressed: () {},
                      ),
                      const SizedBox(height: 10),
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
                              color: Color.fromARGB(255, 78, 77, 77),
                              thickness: 1,
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
                              color: Color.fromARGB(255, 78, 77, 77),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
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
                                  builder: (context) => const Signup(),
                                ),
                              );
                            },
                            child: Text(
                              " Sign up",
                              style: GoogleFonts.inter(
                                color: const Color.fromRGBO(79, 70, 229, 100),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
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