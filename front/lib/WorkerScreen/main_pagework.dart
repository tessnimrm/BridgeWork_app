import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import '../widgets/background.dart';
import '../widgets/categories.dart';
import '../widgets/cards.dart';
import '../CompanyScreen/main_pagehire.dart';
import '../WorkerScreen/bottomBarWorker.dart';
import '../Routes.dart';
import '../providers/WorkerProvider.dart';
import '../providers/LikedJobsProvider.dart';
import '../models/JobModel.dart';
import '../WorkerScreen/theirProfile.dart';

class Work extends StatefulWidget {
  const Work({super.key});

  @override
  State<Work> createState() => _WorkState();
}

class _WorkState extends State<Work> {
  final List<JobModel> jobs = [
    JobModel(
      title: "Sarah Johnson",
      place: "Teacher",
      timing: "Morning",
      flexibility: "Flexible",
      imageUrl:
          "https://i.pinimg.com/736x/c1/ec/37/c1ec37f6e663304eecdf8cf0f9b0c116.jpg",
    ),
    JobModel(
      title: "Michael Chen",
      place: "Chef",
      timing: "Full-time",
      flexibility: "Immediate",
      imageUrl:
          "https://i.pinimg.com/736x/c1/ec/37/c1ec37f6e663304eecdf8cf0f9b0c116.jpg",
    ),
    JobModel(
      title: "Emma Davis",
      place: "Waitress",
      timing: "Evening",
      flexibility: "Part-time",
      imageUrl:
          "https://i.pinimg.com/736x/c1/ec/37/c1ec37f6e663304eecdf8cf0f9b0c116.jpg",
    ),
    JobModel(
      title: "David Kim",
      place: "UI/UX Designer",
      timing: "Remote",
      flexibility: "Flexible",
      imageUrl:
          "https://i.pinimg.com/736x/c1/ec/37/c1ec37f6e663304eecdf8cf0f9b0c116.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final likedProvider = Provider.of<LikedJobsProvider>(context);
    final workerProvider = Provider.of<WorkerProvider>(context);
    final data = workerProvider.workerData;
    final fullName = data?.fullName.isNotEmpty == true
        ? data!.fullName
        : 'User';

    ImageProvider profileImage;
    if (data?.profileImagePath != null && data!.profileImagePath.isNotEmpty) {
      final file = File(data.profileImagePath);
      if (file.existsSync()) {
        profileImage = FileImage(file);
      } else {
        profileImage = const AssetImage('lib/images/photo_2.jpg');
      }
    } else {
      profileImage = const AssetImage('lib/images/photo_2.jpg');
    }

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
                          const SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                " Hi $fullName!",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                "Find your next job",
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
                          const SizedBox(width: 100),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color.fromARGB(
                              255,
                              60,
                              57,
                              63,
                            ),
                            backgroundImage: profileImage,
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      Container(
                        height: 48,
                        width: 340,
                        padding: const EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(131, 125, 225, 0.3),
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

                      const SizedBox(height: 20),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 10,
                          children: <Widget>[
                            const SizedBox(width: 10),
                            Categories(
                              text: "Retail",
                              imagePath: "lib/images/retail.png",
                            ),
                            Categories(
                              text: "Hospitality",
                              imagePath: "lib/images/hospitality.png",
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
                              imagePath: "lib/images/business.png",
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                      Wrap(
                        runSpacing: 15,
                        spacing: 15,
                        children: jobs.map((job) {
                          final isLiked = likedProvider.isLiked(job);
                          return Cards(
                            textt: job.title,
                            avatar: NetworkImage(job.imageUrl),
                            place: job.place,
                            timing: job.timing,
                            flixebility: job.flexibility,
                            isLiked: isLiked,
                            onLikePressed: () {
                              if (isLiked) {
                                likedProvider.removeJob(job);
                              } else {
                                likedProvider.addJob(job);
                              }
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Theirprofile(
                                    worker: job,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 50),
                    ],
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
          if (index == 0) {
            // stay
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/messages');
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