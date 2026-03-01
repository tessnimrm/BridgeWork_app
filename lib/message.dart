import 'package:flutter/material.dart';
import 'package:careermatch_app/bottomBar.dart'; // استيراد البار

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('صفحة الرسائل', style: TextStyle(fontSize: 24))),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 1, // 1 لأننا في صفحة الرسائل
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            // احنا في Message
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/settings');
          }
        },
      ),
    );
  }
}
