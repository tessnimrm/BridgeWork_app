import 'package:brigdeWork_app/WorkerScreen/Workersettings.dart';
import 'package:brigdeWork_app/WorkerScreen/bottomBarWorker.dart';
import 'package:brigdeWork_app/WorkerScreen/editWorkerProfile.dart';
import 'package:brigdeWork_app/shared_pages/background.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:brigdeWork_app/shared_pages/Routes.dart';
import 'package:brigdeWork_app/providers/WorkerProvider.dart';
import 'package:provider/provider.dart';
import 'package:brigdeWork_app/WorkerScreen/workerProfileSet.dart';
import 'dart:io';

class ProfileWorker extends StatefulWidget {
  const ProfileWorker({super.key});

  @override
  State<ProfileWorker> createState() => _ProfileWorkerState();
}

class _ProfileWorkerState extends State<ProfileWorker> {
  bool isEducationVisible = false;
  bool isExperienceVisible = false;
  bool isProjectsVisible = false;

  @override
  Widget build(BuildContext context) {
    final workerProvider = Provider.of<WorkerProvider>(context);
    final data = workerProvider.workerData;

    if (data == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WorkerProfileSet()),
        );
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final coverImage = data.coverImagePath.isNotEmpty
        ? FileImage(File(data.coverImagePath))
        : const AssetImage('lib/images/photo_1.jpg') as ImageProvider;
    final profileImage = data.profileImagePath.isNotEmpty
        ? FileImage(File(data.profileImagePath))
        : const AssetImage('lib/images/photo_2.jpg') as ImageProvider;

    // جمع كل المهارات (المهارات الأساسية فقط، لأن customJobs هي وظائف مخصصة)
    final allSkills = <String>[];

    // إضافة المهارات الأساسية إذا كانت موجودة
    if (data.selectedSkills != null && data.selectedSkills.isNotEmpty) {
      allSkills.addAll(data.selectedSkills);
    }

    // الطريقة الصحيحة لدمج القوائم
    final allLanguages = [...data.selectedLanguages, ...data.customLanguages];
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
                                image: coverImage,
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
                                    image: profileImage,
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
                              data.fullName.isNotEmpty
                                  ? data.fullName
                                  : 'YOUR NAME',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // إظهار المهنة المختارة
                            Text(
                              data.selectedJob.isNotEmpty
                                  ? data.selectedJob
                                  : 'No job selected',
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
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    // كارد المهارات (يبقى موجود حتى لو كان فارغاً)
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
                                              if (allSkills.isNotEmpty)
                                                Wrap(
                                                  spacing: 8,
                                                  runSpacing: 8,
                                                  children: allSkills.map((
                                                    skill,
                                                  ) {
                                                    return Container(
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
                                                      child: Text(
                                                        skill,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                )
                                              else
                                                const Text(
                                                  "",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontStyle: FontStyle.italic,
                                                  ),
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
                                                children: data.selectedAvailability.map((
                                                  availability,
                                                ) {
                                                  return Container(
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
                                                      availability,
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
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
                                            data.bio.isEmpty
                                                ? "No bio added"
                                                : data.bio,
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
                            if (isEducationVisible && data.education.isNotEmpty)
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
                                      data.education,
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
                              title: "Experience",
                              isVisible: isExperienceVisible,
                              onTap: () {
                                setState(() {
                                  isExperienceVisible = !isExperienceVisible;
                                });
                              },
                            ),
                            if (isExperienceVisible &&
                                data.experience.isNotEmpty)
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
                                      data.experience,
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
                            if (isProjectsVisible && data.projects.isNotEmpty)
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
                                      data.projects,
                                      style: const TextStyle(
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
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, Routes.Work);
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, Routes.MessagesPage);
          } else if (index == 2) {
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
