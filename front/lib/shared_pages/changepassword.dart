import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:brigdeWork_app/shared_pages/background.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  bool _showOld = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(child: SizedBox.expand()),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 28,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                        const Text(
                          "Change Password",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildLabel("Your old password"),
                  const SizedBox(height: 8),
                  _buildPasswordField(
                    isObscure: !_showOld,
                    onTapEye: () => setState(() => _showOld = !_showOld),
                  ),
                  const SizedBox(height: 20),
                  _buildLabel("New password"),
                  const SizedBox(height: 8),
                  _buildPasswordField(
                    isObscure: !_showNew,
                    onTapEye: () => setState(() => _showNew = !_showNew),
                  ),
                  const SizedBox(height: 20),
                  _buildLabel("Confirm Your new password"),
                  const SizedBox(height: 8),
                  _buildPasswordField(
                    isObscure: !_showConfirm,
                    onTapEye: () =>
                        setState(() => _showConfirm = !_showConfirm),
                  ),
                  const SizedBox(height: 70),
                  Center(
                    child: SizedBox(
                      width: 320,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(79, 70, 229, 1),
                                Color.fromRGBO(131, 125, 225, 1),
                                Color.fromRGBO(217, 217, 217, 1),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                              minWidth: 320,
                              minHeight: 48,
                            ),
                            child: const Text(
                              "Change",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Forget password?',
                      style: TextStyle(
                        fontSize: 15,
                        color: HexColor("#4F46E5"),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required bool isObscure,
    required VoidCallback onTapEye,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: HexColor("#D9D9D9"),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        obscureText: isObscure,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: onTapEye,
              child: Icon(
                isObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey.shade600,
                size: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
