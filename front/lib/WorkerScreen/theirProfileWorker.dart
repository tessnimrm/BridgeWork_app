import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../shared_pages/background.dart';
import '../models/JobModel.dart';
import 'package:provider/provider.dart';
import '../providers/RequestProvider.dart';
import '../models/RequestModel.dart';
import 'bottomBarWorker.dart';
import 'package:brigdeWork_app/shared_pages/Routes.dart';

class Theirprofile extends StatefulWidget {
  final JobModel worker;
  const Theirprofile({super.key, required this.worker});

  @override
  State<Theirprofile> createState() => _TheirprofileState();
}

class _TheirprofileState extends State<Theirprofile> {
  bool isEducationVisible = false;
  bool isExperienceVisible = false;
  bool isProjectsVisible = false;

  @override
  Widget build(BuildContext context) {
    final requestsProvider = Provider.of<RequestsProvider>(context);
    final worker = widget.worker;
    final profileUserId = worker.title;
    final requestStatus = requestsProvider.getRequestStatus(profileUserId);

    return Scaffold(
      body: SafeArea(
        child: GradientBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 152,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: const AssetImage(
                                  'lib/images/photo_1.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Positioned(
                            top: 100,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(worker.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Text(
                              worker.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              worker.place,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: HexColor("#837DE1"),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "CV",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (requestStatus == 'none') {
                                    final request = RequestModel(
                                      id: profileUserId,
                                      jobTitle: worker.place,
                                      workerName: worker.title,
                                      workerImage: worker.imageUrl,
                                      status: 'pending',
                                      date: DateTime.now(),
                                    );
                                    requestsProvider.receiveRequest(request);
                                    setState(() {});
                                  } else if (requestStatus == 'accepted') {
                                    Navigator.pushNamed(context, '/chat');
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: requestStatus == 'none'
                                        ? HexColor("#F9FAFB")
                                        : HexColor("#837DE1"),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      requestStatus == 'accepted'
                                          ? "Message"
                                          : requestStatus == 'pending'
                                          ? "Request Sent"
                                          : "Interested",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [
                                                  Icon(Icons.code, size: 16),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    "Skills",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Wrap(
                                                spacing: 8,
                                                runSpacing: 8,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 6,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: HexColor(
                                                        "#D9D9D9",
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                    child: const Text(
                                                      "Flutter",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 12,
                                                          vertical: 6,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: HexColor(
                                                        "#D9D9D9",
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                    child: const Text(
                                                      "UI/UX",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                children: [
                                                  Icon(
                                                    Icons.access_time,
                                                    size: 16,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    "Availability",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Wrap(
                                                spacing: 4,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 4,
                                                        ),
                                                    margin:
                                                        const EdgeInsets.only(
                                                          bottom: 4,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: HexColor(
                                                        "#D9D9D9",
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      worker.timing,
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 4,
                                                        ),
                                                    margin:
                                                        const EdgeInsets.only(
                                                          bottom: 4,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: HexColor(
                                                        "#D9D9D9",
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      worker.flexibility,
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.person_outline,
                                                size: 16,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "About me",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Experienced ${worker.place} with 5+ years in the field",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              height: 1.4,
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
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            _buildMainCard(
                              title: "Education",
                              isVisible: isEducationVisible,
                              onTap: () {
                                setState(() {
                                  isEducationVisible = !isEducationVisible;
                                });
                              },
                            ),
                            if (isEducationVisible)
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                width: double.infinity,
                                child: Card(
                                  color: HexColor("#E5E7EB"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      "Bachelor's in Computer Science",
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 12),
                            _buildMainCard(
                              title: "Experience",
                              isVisible: isExperienceVisible,
                              onTap: () {
                                setState(() {
                                  isExperienceVisible = !isExperienceVisible;
                                });
                              },
                            ),
                            if (isExperienceVisible)
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                width: double.infinity,
                                child: Card(
                                  color: HexColor("#E5E7EB"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      "5 years as ${worker.place}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 12),
                            _buildMainCard(
                              title: "Projects",
                              isVisible: isProjectsVisible,
                              onTap: () {
                                setState(() {
                                  isProjectsVisible = !isProjectsVisible;
                                });
                              },
                            ),
                            if (isProjectsVisible)
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                width: double.infinity,
                                child: Card(
                                  color: HexColor("#E5E7EB"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      "E-commerce App, Portfolio Website",
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/messages');
          } else if (index == 2) {
            Navigator.pushNamed(context, Routes.workerProfile);
          } else if (index == 3) {
            Navigator.pushNamed(context, Routes.workerSettings);
          }
        },
      ),
    );
  }

  Widget _buildMainCard({
    required String title,
    required bool isVisible,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: HexColor("#E5E7EB"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Icon(
                  isVisible
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
