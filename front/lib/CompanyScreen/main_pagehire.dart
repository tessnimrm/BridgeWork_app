// CompanyScreen/main_pagehire.dart
import 'package:brigdeWork_app/WorkerScreen/main_pagework.dart';
import 'package:flutter/material.dart';
import '../widgets/background.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/categories.dart';
import '../widgets/cards.dart';
import 'package:provider/provider.dart';
import '../providers/CompanyProvider.dart';
import 'package:brigdeWork_app/CompanyScreen/bottomBarCompany.dart';
import 'package:brigdeWork_app/shared_pages/Routes.dart';
import '../models/JobModel.dart';
import '../models/RequestModel.dart';
import 'package:brigdeWork_app/providers/CompanyLiked.dart';
import 'package:brigdeWork_app/providers/CompanyRequest.dart';
import 'package:brigdeWork_app/CompanyScreen/theirProfileCompany.dart';
import 'dart:io';

class Hire extends StatefulWidget {
  const Hire({super.key});

  @override
  State<Hire> createState() => _HireState();
}

class _HireState extends State<Hire> {
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
    // حالة عدم وجود صورة
    if (imagePath == null || imagePath.isEmpty) {
      return const CircleAvatar(
        radius: 30,
        backgroundColor: Color.fromARGB(255, 132, 125, 138),
        child: Icon(Icons.business, size: 30, color: Colors.white),
      );
    }

    // استخدام Key فريد يجبر Flutter على تحديث الصورة فور تغير المسار
    return CircleAvatar(
      key: ValueKey(imagePath),
      radius: 30,
      backgroundColor: const Color.fromARGB(255, 132, 125, 138),
      backgroundImage: _buildImageProvider(imagePath),
    );
  }

  // دالة مساعدة لفصل منطق جلب الصورة
  ImageProvider _buildImageProvider(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path);
    } else if (path.startsWith('file://')) {
      return FileImage(File(path.replaceFirst('file://', '')));
    } else {
      // في حال كان المسار محلياً بدون file://
      return FileImage(File(path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final companyProvider = Provider.of<CompanyProvider>(context);
    final likedProvider = Provider.of<CompanyLikedWorkersProvider>(context);
    final requestsProvider = Provider.of<CompanyRequestsProvider>(context);

    String companyName = companyProvider.companyData?.companyName ?? 'Company';
    String companyLogo = companyProvider.companyData?.logoImagePath ?? '';

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: GradientBackground(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(width: 20),
                          const BackButton(),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                companyName,
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
                              // انتظر العودة من صفحة البروفايل
                              final result = await Navigator.pushNamed(
                                context,
                                Routes.companyProfile,
                              );

                              if (mounted) {
                                setState(() {
                                  // هذا سيجبر الواجهة على إعادة قراءة القيم من Provider
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: _getCompanyImage(companyLogo),
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
                          boxShadow: [],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 77, 76, 76),
                              fontSize: 20,
                            ),
                            prefixIcon: const Icon(
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
                          children: <Widget>[
                            const SizedBox(width: 10),
                            const Categories(
                              text: "Retail",
                              imagePath: "lib/images/retail.png",
                            ),
                            const Categories(
                              text: "Hospitality",
                              imagePath: "lib/images/hospitality.png",
                            ),
                            const Categories(
                              text: "Tech&Digital",
                              imagePath: "lib/images/tech.png",
                            ),
                            const Categories(
                              text: "Education",
                              imagePath: "lib/images/education.png",
                            ),
                            const Categories(
                              text: "Buisness",
                              imagePath: "lib/images/buuisness.png",
                            ),
                            const SizedBox(width: 10),
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
                          final requestStatus = requestsProvider
                              .getRequestStatus(job['title'] as String);

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
                                  builder: (context) =>
                                      TheirProfileCompany(worker: workerJob),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 100),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Work()),
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
                  "Switch to Work mode",
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
      bottomNavigationBar: CustomBottomBarCompany(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
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
}
