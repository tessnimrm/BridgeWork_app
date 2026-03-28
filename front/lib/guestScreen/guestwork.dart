import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../widgets/background.dart';
import '../widgets/categories.dart';
import '../widgets/cards.dart';
import 'package:brigdeWork_app/WorkerScreen/bottomBarWorker.dart';
import '../models/JobModel.dart';
import '../providers/WorkerProvider.dart';
import '../providers/CompanyLiked.dart';
import '../providers/CompanyRequest.dart';
import '../shared_pages/Routes.dart';
import 'package:brigdeWork_app/WorkerScreen/theirProfileWorker.dart';
import '../guestScreen/guesthire.dart';

class Workg extends StatefulWidget {
  const Workg({super.key});

  @override
  State<Workg> createState() => _WorkgState();
}

class _WorkgState extends State<Workg> {
  // Sample job data
  final List<Map<String, dynamic>> jobs = [
    {
      'title': 'Sarah Johnson',
      'place': 'Teacher',
      'timing': 'Morning',
      'flexibility': 'Flexible',
      'profileImage': 'https://randomuser.me/api/portraits/women/1.jpg',
    },
    {
      'title': 'Michael Chen',
      'place': 'Chef',
      'timing': 'Full-time',
      'flexibility': 'Immediate',
      'profileImage': 'https://randomuser.me/api/portraits/men/2.jpg',
    },
    {
      'title': 'Emma Davis',
      'place': 'Waitress',
      'timing': 'Evening',
      'flexibility': 'Part-time',
      'profileImage': 'https://randomuser.me/api/portraits/women/3.jpg',
    },
    {
      'title': 'David Kim',
      'place': 'UI/UX Designer',
      'timing': 'Remote',
      'flexibility': 'Flexible',
      'profileImage': 'https://randomuser.me/api/portraits/men/4.jpg',
    },
  ];

  JobModel _convertToJobModel(Map<String, dynamic> job) {
    return JobModel(
      title: job['title'] as String,
      place: job['place'] as String,
      timing: job['timing'] as String,
      flexibility: job['flexibility'] as String,
      imageUrl: job['profileImage'] as String,
    );
  }

  Widget _getCompanyImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return const CircleAvatar(
        radius: 30,
        backgroundColor: Color.fromARGB(255, 132, 125, 138),
        child: Icon(Icons.person, size: 30, color: Colors.white),
      );
    }

    ImageProvider imageProvider;
    if (imagePath.startsWith('http')) {
      imageProvider = NetworkImage(imagePath);
    } else if (imagePath.startsWith('file://')) {
      imageProvider = FileImage(File(imagePath.replaceFirst('file://', '')));
    } else {
      imageProvider = FileImage(File(imagePath));
    }

    return CircleAvatar(
      key: ValueKey(imagePath),
      radius: 30,
      backgroundColor: const Color.fromARGB(255, 132, 125, 138),
      backgroundImage: imageProvider,
    );
  }

  @override
  Widget build(BuildContext context) {
    final workerProvider = Provider.of<WorkerProvider>(context);
    final likedProvider = Provider.of<CompanyLikedWorkersProvider>(context);
    final requestsProvider = Provider.of<CompanyRequestsProvider>(context);

    final workerName = workerProvider.workerData?.fullName ?? 'Worker';
    final workerImage = workerProvider.workerData?.profileImagePath ?? '';

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: SafeArea(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: GradientBackground(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const BackButton(),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                workerName,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                "That's Hire mode",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: const Color.fromARGB(
                                    255,
                                    103,
                                    101,
                                    101,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                Routes.companyProfile,
                              );
                              if (mounted) setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: _getCompanyImage(workerImage),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 48,
                        width: 320,
                        padding: const EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(188, 194, 194, 194),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 77, 76, 76),
                              fontSize: 20,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color.fromARGB(255, 134, 132, 132),
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 10,
                          children: const [
                            SizedBox(width: 10),
                            Categories(
                              text: "Retail",
                              imagePath: "lib/images/retail.png",
                            ),
                            Categories(
                              text: "Hospitality",
                              imagePath: "lib/images/hospitalityy.png",
                            ),
                            Categories(
                              text: "Tech&Digital",
                              imagePath: "lib/images/tech.png",
                            ),
                            Categories(
                              text: "Education",
                              imagePath: "lib/images/education.png",
                            ),
                            Categories(
                              text: "Business",
                              imagePath: "lib/images/buuisness.png",
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        runSpacing: 15,
                        spacing: 15,
                        children: jobs.map((job) {
                          final workerJob = _convertToJobModel(job);
                          final isLiked = likedProvider.isLiked(workerJob);

                          return Cards(
                            textt: job['title'] as String,
                            avatar: NetworkImage(job['profileImage'] as String),
                            place: job['place'] as String,
                            timing: job['timing'] as String,
                            flixebility: job['flexibility'] as String,
                            isLiked: isLiked,
                            onLikePressed: () {
                              if (isLiked) {
                                likedProvider.removeWorker(workerJob);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Removed from liked workers'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else {
                                likedProvider.addWorker(workerJob);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added to liked workers'),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      Theirprofile(worker: workerJob),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const Hireg()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 114, 110, 202),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                ),
                child: const Text(
                  "Switch to Hire mode",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushReplacementNamed(context, Routes.MessagesPage);
              break;
            case 2:
              Navigator.pushReplacementNamed(context, Routes.workerProfile);
              break;
            case 3:
              Navigator.pushReplacementNamed(context, Routes.workerSettings);
              break;
          }
        },
      ),
    );
  }
}
