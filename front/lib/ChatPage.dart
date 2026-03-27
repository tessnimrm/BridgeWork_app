import 'package:flutter/material.dart';
import './models/modelsChat.dart';
import '../WorkerScreen/bottomBarWorker.dart';
import 'shared_pages/Routes.dart';

class ChatPage extends StatefulWidget {
  final String name;
  final String? imageUrl;

  const ChatPage({super.key, required this.name, this.imageUrl});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController controller = TextEditingController();

  List<Message> messages = [
    Message(text: "Hello! How are you?", isMe: false, time: DateTime.now()),
    Message(
      text: "Hi! I'm good, thanks. What about you?",
      isMe: true,
      time: DateTime.now(),
    ),
  ];

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      messages.add(
        Message(text: controller.text, isMe: true, time: DateTime.now()),
      );
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Column(
        children: [
          // Top bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, left: 16, bottom: 16),
            color: const Color.fromARGB(255, 162, 130, 215),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: widget.imageUrl != null
                      ? NetworkImage(widget.imageUrl!)
                      : const AssetImage('assets/images/default_avatar.png')
                            as ImageProvider,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[messages.length - 1 - index];
                final isMe = msg.isMe;

                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Profile picture for the other person
                      if (!isMe && widget.imageUrl != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(widget.imageUrl!),
                          ),
                        ),
                      // Message bubble
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? const Color.fromARGB(255, 162, 130, 215)
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(12),
                                  topRight: const Radius.circular(12),
                                  bottomLeft: Radius.circular(isMe ? 12 : 0),
                                  bottomRight: Radius.circular(isMe ? 0 : 12),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    msg.text,
                                    style: TextStyle(
                                      color: isMe ? Colors.white : Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${msg.time.hour.toString().padLeft(2, '0')}:${msg.time.minute.toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isMe
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Tail/flesh effect
                            Positioned(
                              bottom: 0,
                              left: isMe ? null : -6,
                              right: isMe ? -6 : null,
                              child: CustomPaint(
                                painter: _MessageTailPainter(isMe: isMe),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Input field
          Container(
            padding: const EdgeInsets.all(10),
            color: const Color(0xFFF0F0F0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 157, 124, 200),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 162, 130, 215),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, Routes.Work);
          } else if (index == 1) {
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, Routes.workerProfile);
          } else if (index == 3) {
            Navigator.pushNamed(context, Routes.workerSettings);
          }
        },
      ),
    );
  }
}

// Painter for the message bubble tail
class _MessageTailPainter extends CustomPainter {
  final bool isMe;
  _MessageTailPainter({required this.isMe});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isMe
          ? const Color.fromARGB(255, 162, 130, 215)
          : Colors.grey.shade300
      ..style = PaintingStyle.fill;

    final path = Path();
    if (isMe) {
      path.moveTo(0, 0);
      path.lineTo(6, 6);
      path.lineTo(0, 12);
    } else {
      path.moveTo(6, 0);
      path.lineTo(0, 6);
      path.lineTo(6, 12);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
