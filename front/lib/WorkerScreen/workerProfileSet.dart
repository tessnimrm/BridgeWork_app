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
  String? selectedJob; // تغيير من Set إلى String واحد
  Set<String> selectedAvailability = {};
  Set<String> selectedLanguage = {};
  final TextEditingController _bioController = TextEditingController();

  List<String> customJobs = []; // تغيير من customSkills إلى customJobs
  List<String> customLanguages = [];

  List<String> jobTypes = [
    "Cooking",
    "Waiter",
    "Delivery",
    "UI/UX Design",
  ]; // تغيير من workTypes إلى jobTypes
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
      // التحقق من وجود وظيفة محددة
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a job'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
        ),
      );
      return false;
    }

    if (selectedAvailability.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select at least one availability option'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
        ),
      );
      return false;
    }

    if (selectedLanguage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please select at least one communication skill option',
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
        ),
      );
      return false;
    }

    return true;
  }

  void _addNewJob() {
    // تغيير من _addNewSkill إلى _addNewJob
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
                    // إضافة الوظيفة إلى customJobs
                    if (!customJobs.contains(newJob)) {
                      customJobs.add(newJob);
                    }
                    // اختيار الوظيفة تلقائياً (تعيينها كوظيفة محددة)
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
                    // إضافة اللغة إلى customLanguages
                    if (!customLanguages.contains(newLanguage)) {
                      customLanguages.add(newLanguage);
                    }
                    // اختيار اللغة تلقائياً (إضافتها إلى selectedLanguage)
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

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 71),
                width: double.infinity,
                child: const Text(
                  "Set up your profile",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                child: const Text(
                  "It's quick and easy. You can edit this later.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(color: Colors.grey, thickness: 1.0, height: 30.0),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "What job are you looking for?", // تغيير النص
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          // الوظائف الأساسية
                          ...jobTypes.map((job) {
                            final isSelected =
                                selectedJob ==
                                job; // تغيير المنطق للاختيار الفردي
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedJob = null; // إلغاء الاختيار
                                  } else {
                                    selectedJob = job; // اختيار الوظيفة
                                  }
                                });
                              },
                              child: Card(
                                color: isSelected
                                    ? HexColor("#4F46E5")
                                    : HexColor("#D9D9D9"),
                                child: Container(
                                  height: 30,
                                  width: 90,
                                  alignment: Alignment.center,
                                  child: Text(
                                    job,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),

                          // الوظائف المخصصة
                          ...customJobs.map((job) {
                            final isSelected =
                                selectedJob ==
                                job; // تغيير المنطق للاختيار الفردي
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedJob = null; // إلغاء الاختيار
                                  } else {
                                    selectedJob = job; // اختيار الوظيفة
                                  }
                                });
                              },
                              child: Card(
                                color: isSelected
                                    ? HexColor("#4F46E5")
                                    : HexColor("#D9D9D9"),
                                child: Container(
                                  height: 30,
                                  width: 90,
                                  alignment: Alignment.center,
                                  child: Text(
                                    job,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),

                          // زر Add
                          GestureDetector(
                            onTap: _addNewJob, // تغيير الدالة
                            child: Card(
                              color: HexColor("#D9D9D9"),
                              child: Container(
                                height: 30,
                                width: 70,
                                alignment: Alignment.center,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 14,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "Add",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Divider(
                        color: Colors.black,
                        thickness: 0.5,
                        height: 20,
                      ),

                      const Text(
                        "Availability",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: availabilityTypes.map((availability) {
                          final isSelected = selectedAvailability.contains(
                            availability,
                          );
                          return SizedBox(
                            width: (screenWidth - 40 - 36) / 4,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedAvailability.remove(availability);
                                  } else {
                                    selectedAvailability.add(availability);
                                  }
                                });
                              },
                              child: Card(
                                color: isSelected
                                    ? HexColor("#4F46E5")
                                    : HexColor("#D9D9D9"),
                                child: Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: Text(
                                    availability,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const Divider(
                        color: Colors.black,
                        thickness: 0.5,
                        height: 20,
                      ),

                      const Text(
                        "Communication Skills",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          // اللغات الأساسية
                          ...Languages.map((language) {
                            final isSelected = selectedLanguage.contains(
                              language,
                            );
                            return SizedBox(
                              width: (screenWidth - 40 - 36) / 4,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedLanguage.remove(language);
                                    } else {
                                      selectedLanguage.add(language);
                                    }
                                  });
                                },
                                child: Card(
                                  color: isSelected
                                      ? HexColor("#4F46E5")
                                      : HexColor("#D9D9D9"),
                                  child: Container(
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: Text(
                                      language,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),

                          ...customLanguages.map((language) {
                            final isSelected = selectedLanguage.contains(
                              language,
                            );
                            return SizedBox(
                              width: (screenWidth - 40 - 36) / 4,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedLanguage.remove(language);
                                    } else {
                                      selectedLanguage.add(language);
                                    }
                                  });
                                },
                                child: Card(
                                  color: isSelected
                                      ? HexColor("#4F46E5")
                                      : HexColor("#D9D9D9"),
                                  child: Container(
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: Text(
                                      language,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),

                          // زر Add Language
                          SizedBox(
                            width: (screenWidth - 40 - 36) / 4,
                            child: GestureDetector(
                              onTap: _addNewLanguage,
                              child: Card(
                                color: HexColor("#D9D9D9"),
                                child: Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 12,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "Add",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
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

                      const Divider(
                        color: Colors.black,
                        thickness: 0.5,
                        height: 20,
                      ),

                      const Text(
                        "Short Bio",
                        style: TextStyle(
                          fontSize: 14,
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
                            hintText: 'tell us more about yourself...',
                            hintStyle: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 14,
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
                            width: 130,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
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
                                    final workerProvider =
                                        Provider.of<WorkerProvider>(
                                          context,
                                          listen: false,
                                        );

                                    final existingData =
                                        workerProvider.workerData;

                                    if (existingData != null) {
                                      // تحديث البيانات الموجودة
                                      workerProvider.updateProfile(
                                        selectedJob: selectedJob!,
                                        selectedSkills: existingData
                                            .selectedSkills, // الاحتفاظ بالمهارات الموجودة
                                        selectedAvailability:
                                            selectedAvailability.toList(),
                                        selectedLanguages: selectedLanguage
                                            .toList(),
                                        customJobs: customJobs,
                                        customLanguages: customLanguages,
                                        bio: _bioController.text,
                                        fullName: existingData.fullName,
                                        email: existingData.email,
                                        phone: existingData.phone,
                                        education: existingData.education,
                                        experience: existingData.experience,
                                        projects: existingData.projects,
                                        coverImagePath:
                                            existingData.coverImagePath,
                                        profileImagePath:
                                            existingData.profileImagePath,
                                      );
                                    } else {
                                      // إنشاء بيانات جديدة
                                      workerProvider.createProfile(
                                        selectedJob: selectedJob!,
                                        selectedSkills:
                                            [], // قائمة فارغة للمهارات
                                        selectedAvailability:
                                            selectedAvailability.toList(),
                                        selectedLanguages: selectedLanguage
                                            .toList(),
                                        customJobs: customJobs,
                                        customLanguages: customLanguages,
                                        bio: _bioController.text,
                                        fullName: '', // سيتم تعبئتها لاحقاً
                                        email: '', // سيتم تعبئتها لاحقاً
                                      );
                                    }

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileWorker(),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
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
}
