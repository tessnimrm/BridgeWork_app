import 'package:brigdeWork_app/WorkerScreen/profileWorker.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../shared_pages/background.dart';
import 'package:provider/provider.dart';
import '../models/WorkerModel.dart';
import '../providers/WorkerProvider.dart';

class WorkerProfileSet extends StatefulWidget {
  const WorkerProfileSet({super.key});

  @override
  State<WorkerProfileSet> createState() => _WorkerProfileSetState();
}

class _WorkerProfileSetState extends State<WorkerProfileSet> {
  String? selectedJob;
  Set<String> selectedAvailability = {};
  Set<String> selectedLanguage = {};
  final TextEditingController _bioController = TextEditingController();

  List<String> customJobs = [];
  List<String> customLanguages = [];

  List<String> jobTypes = [
    "Cooking",
    "Waiter",
    "Delivery",
    "UI/UX Design",
  ];
  List<String> availabilityTypes = [
    "morning",
    "afternoon",
    "evening",
    "night",
    "weekdays",
    "weekends",
    "part time",
    "full time",
  ];
  List<String> Languages = ["English", "Arabic", "French"];

  bool _validateInputs() {
    if (selectedJob == null) {
      _showSnackBar('Please select a job');
      return false;
    }

    if (selectedAvailability.isEmpty) {
      _showSnackBar('Please select at least one availability option');
      return false;
    }

    if (selectedLanguage.isEmpty) {
      _showSnackBar('Please select at least one communication skill option');
      return false;
    }

    return true;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  void _addNewJob() {
    TextEditingController jobController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Job'),
          content: TextField(
            controller: jobController,
            decoration: const InputDecoration(
              hintText: 'Enter job name',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                String newJob = jobController.text.trim();
                if (newJob.isNotEmpty) {
                  setState(() {
                    if (!customJobs.contains(newJob)) {
                      customJobs.add(newJob);
                    }
                    selectedJob = newJob;
                  });
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor("#4F46E5"),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addNewLanguage() {
    TextEditingController languageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Language'),
          content: TextField(
            controller: languageController,
            decoration: const InputDecoration(
              hintText: 'Enter language name',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                String newLanguage = languageController.text.trim();
                if (newLanguage.isNotEmpty) {
                  setState(() {
                    if (!customLanguages.contains(newLanguage)) {
                      customLanguages.add(newLanguage);
                    }
                    selectedLanguage.add(newLanguage);
                  });
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor("#4F46E5"),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;
    
    // Responsive sizes
    final titleFontSize = isSmallScreen ? 24.0 : 28.0;
    final subtitleFontSize = isSmallScreen ? 12.0 : 14.0;
    final sectionFontSize = isSmallScreen ? 12.0 : 14.0;
    final buttonWidth = screenWidth * 0.35;
    final cardWidth = (screenWidth - 60) / (isSmallScreen ? 3 : 4);
    final topMargin = screenHeight * 0.05;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  children: [
                    SizedBox(height: topMargin),
                    Row(
                      children: [
                        const BackButton(),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: Text(
                            "Set up your profile",
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 40), // Balance for BackButton
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "It's quick and easy. You can edit this later.",
                      style: TextStyle(
                        fontSize: subtitleFontSize,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(color: Colors.grey, thickness: 1.0, height: 30.0),
                  ],
                ),
              ),
              
              // Form Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Job Section
                      Text(
                        "What job are you looking for?",
                        style: TextStyle(
                          fontSize: sectionFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ...jobTypes.map((job) => _buildSelectionChip(
                            label: job,
                            isSelected: selectedJob == job,
                            onTap: () {
                              setState(() {
                                if (selectedJob == job) {
                                  selectedJob = null;
                                } else {
                                  selectedJob = job;
                                }
                              });
                            },
                            width: cardWidth,
                          )),
                          ...customJobs.map((job) => _buildSelectionChip(
                            label: job,
                            isSelected: selectedJob == job,
                            onTap: () {
                              setState(() {
                                if (selectedJob == job) {
                                  selectedJob = null;
                                } else {
                                  selectedJob = job;
                                }
                              });
                            },
                            width: cardWidth,
                          )),
                          _buildAddChip(
                            onTap: _addNewJob,
                            width: cardWidth,
                            label: "Add",
                          ),
                        ],
                      ),

                      const Divider(color: Colors.black, thickness: 0.5, height: 20),

                      // Availability Section
                      Text(
                        "Availability",
                        style: TextStyle(
                          fontSize: sectionFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: availabilityTypes.map((availability) {
                          final itemWidth = (screenWidth - 40 - 36) / (isSmallScreen ? 3 : 4);
                          return SizedBox(
                            width: itemWidth,
                            child: _buildSelectionChip(
                              label: availability,
                              isSelected: selectedAvailability.contains(availability),
                              onTap: () {
                                setState(() {
                                  if (selectedAvailability.contains(availability)) {
                                    selectedAvailability.remove(availability);
                                  } else {
                                    selectedAvailability.add(availability);
                                  }
                                });
                              },
                              width: itemWidth,
                            ),
                          );
                        }).toList(),
                      ),

                      const Divider(color: Colors.black, thickness: 0.5, height: 20),

                      // Communication Skills Section
                      Text(
                        "Communication Skills",
                        style: TextStyle(
                          fontSize: sectionFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          ...Languages.map((language) {
                            final itemWidth = (screenWidth - 40 - 36) / (isSmallScreen ? 3 : 4);
                            return SizedBox(
                              width: itemWidth,
                              child: _buildSelectionChip(
                                label: language,
                                isSelected: selectedLanguage.contains(language),
                                onTap: () {
                                  setState(() {
                                    if (selectedLanguage.contains(language)) {
                                      selectedLanguage.remove(language);
                                    } else {
                                      selectedLanguage.add(language);
                                    }
                                  });
                                },
                                width: itemWidth,
                              ),
                            );
                          }).toList(),
                          ...customLanguages.map((language) {
                            final itemWidth = (screenWidth - 40 - 36) / (isSmallScreen ? 3 : 4);
                            return SizedBox(
                              width: itemWidth,
                              child: _buildSelectionChip(
                                label: language,
                                isSelected: selectedLanguage.contains(language),
                                onTap: () {
                                  setState(() {
                                    if (selectedLanguage.contains(language)) {
                                      selectedLanguage.remove(language);
                                    } else {
                                      selectedLanguage.add(language);
                                    }
                                  });
                                },
                                width: itemWidth,
                              ),
                            );
                          }).toList(),
                          SizedBox(
                            width: (screenWidth - 40 - 36) / (isSmallScreen ? 3 : 4),
                            child: _buildAddChip(
                              onTap: _addNewLanguage,
                              width: (screenWidth - 40 - 36) / (isSmallScreen ? 3 : 4),
                              label: "Add",
                            ),
                          ),
                        ],
                      ),

                      const Divider(color: Colors.black, thickness: 0.5, height: 20),

                      // Bio Section
                      Text(
                        "Short Bio",
                        style: TextStyle(
                          fontSize: sectionFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: HexColor("#D9D9D9"),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: _bioController,
                          maxLines: 5,
                          minLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Tell us more about yourself...',
                            hintStyle: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontSize: subtitleFontSize,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: buttonWidth,
                            child: Container(
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
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_validateInputs()) {
                                    final workerProvider = Provider.of<WorkerProvider>(
                                      context,
                                      listen: false,
                                    );

                                    final existingData = workerProvider.workerData;

                                    if (existingData != null) {
                                      workerProvider.updateProfile(
                                        selectedJob: selectedJob!,
                                        selectedSkills: existingData.selectedSkills,
                                        selectedAvailability: selectedAvailability.toList(),
                                        selectedLanguages: selectedLanguage.toList(),
                                        customJobs: customJobs,
                                        customLanguages: customLanguages,
                                        bio: _bioController.text,
                                        fullName: existingData.fullName,
                                        email: existingData.email,
                                        phone: existingData.phone,
                                        education: existingData.education,
                                        experience: existingData.experience,
                                        projects: existingData.projects,
                                        coverImagePath: existingData.coverImagePath,
                                        profileImagePath: existingData.profileImagePath,
                                      );
                                    } else {
                                      workerProvider.createProfile(
                                        selectedJob: selectedJob!,
                                        selectedSkills: [],
                                        selectedAvailability: selectedAvailability.toList(),
                                        selectedLanguages: selectedLanguage.toList(),
                                        customJobs: customJobs,
                                        customLanguages: customLanguages,
                                        bio: _bioController.text,
                                        fullName: '',
                                        email: '',
                                      );
                                    }

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ProfileWorker(),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  "Next",
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
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required double width,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 30,
        decoration: BoxDecoration(
          color: isSelected ? HexColor("#4F46E5") : HexColor("#D9D9D9"),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }

  Widget _buildAddChip({
    required VoidCallback onTap,
    required double width,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 30,
        decoration: BoxDecoration(
          color: HexColor("#D9D9D9"),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.black, size: 14),
            const SizedBox(width: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}