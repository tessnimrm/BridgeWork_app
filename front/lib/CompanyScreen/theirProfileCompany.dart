// screens/company/their_profile_company.dart
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../shared_pages/background.dart';
import '../../models/JobModel.dart';
import 'package:provider/provider.dart';
import '../../models/RequestModel.dart';
import 'package:brigdeWork_app/providers/CompanyRequest.dart';
import 'package:brigdeWork_app/CompanyScreen/bottomBarCompany.dart';
import 'package:brigdeWork_app/shared_pages/Routes.dart';

class TheirProfileCompany extends StatefulWidget {
  final JobModel worker;
  const TheirProfileCompany({super.key, required this.worker});

  @override
  State<TheirProfileCompany> createState() => _TheirProfileCompanyState();
}

class _TheirProfileCompanyState extends State<TheirProfileCompany> {
  bool isEducationVisible = false;
  bool isExperienceVisible = false;
  bool isProjectsVisible = false;

  @override
  Widget build(BuildContext context) {
    final requestsProvider = Provider.of<CompanyRequestsProvider>(context);
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
                                                    "Skills needed",
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
                                                      "Firebase",
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
                                                    "Availability ",
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
                                                "About Us",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Experienced ${worker.place} with 5+ years in the field. Passionate about creating innovative solutions and delivering high-quality work.",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              height: 1.4,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 14,
                                                color: Colors.amber,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "4.8 (24 reviews)",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
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
                              title: "Services",
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Bachelor's in Computer Science",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "University of Technology • 2020",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 12),
                            _buildMainCard(
                              title: "Achievements",
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "5+ years as ${worker.place}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          "• Led development of 10+ mobile applications\n• Managed team of 3 junior developers\n• Implemented CI/CD pipelines",
                                          style: TextStyle(
                                            fontSize: 12,
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 12),
                            _buildMainCard(
                              title: "Company Overview",
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "E-commerce App",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Flutter, Firebase, Stripe • 2023",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "Portfolio Website",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "React, Node.js • 2024",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBarCompany(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            // Stay on current page
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, Routes.MessagesPage);
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, Routes.companyProfile);
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, Routes.companySettings);
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

  void _showCVPreview(BuildContext context, JobModel worker) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'CV Preview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Icon(Icons.description, size: 80, color: Colors.grey),
              const SizedBox(height: 20),
              Text(
                worker.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(worker.place),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor('#837DE1'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showContactDialog(
    BuildContext context,
    JobModel worker,
    CompanyRequestsProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Request'),
        content: Text('Would you like to send a request to ${worker.title}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final request = RequestModel(
                id: worker.title,
                jobTitle: worker.place,
                workerName: worker.title,
                workerImage: worker.imageUrl,
                status: 'pending',
                date: DateTime.now(),
              );
              provider.receiveRequest(request);
              Navigator.pop(context);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Request sent successfully!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: HexColor('#837DE1'),
            ),
            child: const Text('Send Request'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
    IconData icon,
    String label,
    int index,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: HexColor("#837DE1"), size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: HexColor("#837DE1")),
          ),
        ],
      ),
    );
  }
}
