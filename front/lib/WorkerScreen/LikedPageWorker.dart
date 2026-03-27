import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:brigdeWork_app/shared_pages/background.dart';
import 'package:provider/provider.dart';
import '../providers/LikedJobsProvider.dart';
import '../widgets/cards.dart';

class Likedpage extends StatefulWidget {
  const Likedpage({super.key});

  @override
  State<Likedpage> createState() => _LikedpageState();
}

class _LikedpageState extends State<Likedpage> {
  @override
  Widget build(BuildContext context) {
    final likedProvider = Provider.of<LikedJobsProvider>(context);
    final likedJobs = likedProvider.likedJobs;

    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(child: SizedBox.expand()),
          SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 122,
                  decoration: BoxDecoration(
                    color: HexColor("#837DE1"),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 28,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const Text(
                        "Liked",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: likedJobs.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No liked jobs yet',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: likedJobs.length,
                          itemBuilder: (context, index) {
                            final job = likedJobs[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Cards(
                                textt: job.title,
                                avatar: NetworkImage(job.imageUrl),
                                place: job.place,
                                timing: job.timing,
                                flixebility: job.flexibility,
                                isLiked: true,
                                onLikePressed: () {
                                  likedProvider.removeJob(job);
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
