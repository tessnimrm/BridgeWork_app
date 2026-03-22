import 'package:brigdeWork_app/WorkerScreen/bottomBarWorker.dart';
import 'package:brigdeWork_app/background.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:brigdeWork_app/Routes.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:brigdeWork_app/models/WorkerModel.dart';
import 'package:provider/provider.dart';

class EditProfileWorker extends StatefulWidget {
  final List<String> selectedWork;
  final List<String> selectedAvailability;
  final List<String> selectedLanguages;
  final List<String> customSkills;
  final List<String> customLanguages;
  final String bio;
  final String education;
  final String experience;
  final String projects;

  const EditProfileWorker({
    super.key,
    this.selectedWork = const [],
    this.selectedAvailability = const [],
    this.selectedLanguages = const [],
    this.customSkills = const [],
    this.customLanguages = const [],
    this.bio = '',
    this.education = '',
    this.experience = '',
    this.projects = '',
  });

  @override
  State<EditProfileWorker> createState() => _EditProfileWorkerState();
}

class _EditProfileWorkerState extends State<EditProfileWorker> {
  File? _coverImage;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  Set<String> selectedWork = {};
  Set<String> selectedAvailability = {};
  Set<String> selectedLanguage = {};
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _projectsController = TextEditingController();

  List<String> customSkills = [];
  List<String> customLanguages = [];

  List<String> workTypes = ["Cooking", "Waiter", "Delivery", "UI/UX Design"];
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

  @override
  void initState() {
    super.initState();
    selectedWork = widget.selectedWork.toSet();
    selectedAvailability = widget.selectedAvailability.toSet();
    selectedLanguage = widget.selectedLanguages.toSet();
    _bioController.text = widget.bio;
    _educationController.text = widget.education;
    _experienceController.text = widget.experience;
    _projectsController.text = widget.projects;
    customSkills = List.from(widget.customSkills);
    customLanguages = List.from(widget.customLanguages);
  }

  Future<void> _pickImage(ImageSource source, bool isCover) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          if (isCover) {
            _coverImage = File(pickedFile.path);
          } else {
            _profileImage = File(pickedFile.path);
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showImageSourceDialog(bool isCover) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCover ? 'Change Cover Photo' : 'Change Profile Photo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery, isCover);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera, isCover);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
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
                                  image: _coverImage != null
                                      ? FileImage(_coverImage!)
                                      : const AssetImage(
                                              'lib/images/photo_1.jpg',
                                            )
                                            as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),

                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () => _showImageSourceDialog(true),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Transform.translate(
                          offset: const Offset(0, -50),
                          child: Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: _profileImage != null
                                          ? FileImage(_profileImage!)
                                          : const AssetImage(
                                                  'lib/images/photo_2.jpg',
                                                )
                                                as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () => _showImageSourceDialog(false),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Text(
                              "Full name",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Container(
                            width: 346,
                            height: 40,
                            decoration: BoxDecoration(
                              color: HexColor("#D9D9D9"),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Your full name',
                                hintStyle: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Text(
                              "Email",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Container(
                            width: 346,
                            height: 40,
                            decoration: BoxDecoration(
                              color: HexColor("#D9D9D9"),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'xxxxxxx@gmail.com',
                                hintStyle: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Text(
                              "Phone number",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Container(
                            width: 346,
                            height: 40,
                            decoration: BoxDecoration(
                              color: HexColor("#D9D9D9"),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: '000000000000',
                                hintStyle: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 13,
                                ),
                              ),
                            ),
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
                                        width: 168,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
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
                                                if (selectedWork.isNotEmpty ||
                                                    customSkills.isNotEmpty)
                                                  Wrap(
                                                    spacing: 8,
                                                    runSpacing: 8,
                                                    children: [
                                                      ...widget.selectedWork.map((
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
                                                            style:
                                                                const TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      ...customSkills.map((
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
                                                            style:
                                                                const TextStyle(
                                                                  fontSize: 12,
                                                                ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      GestureDetector(
                                                        onTap: _addNewSkill,
                                                        child: Container(
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
                                                          child: const Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Icon(
                                                                Icons.add,
                                                                size: 12,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                else
                                                  GestureDetector(
                                                    onTap: _addNewSkill,
                                                    child: Container(
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
                                                      child: const Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons.add,
                                                            size: 12,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    width: 168,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.access_time,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      "Availability",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Wrap(
                                              spacing: 4,
                                              children: [
                                                ...selectedAvailability.map((
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
                                                GestureDetector(
                                                  onTap: _addNewAvailability,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 4,
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
                                                    child: const Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          size: 10,
                                                        ),
                                                      ],
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
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Text(
                              "About me",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Container(
                            width: 346,
                            height: 80,
                            decoration: BoxDecoration(
                              color: HexColor("#D9D9D9"),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              controller: _bioController,
                              minLines: 3,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Tell us about yourself...',
                                hintStyle: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Text(
                              "Education",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Container(
                            width: 346,
                            height: 80,
                            decoration: BoxDecoration(
                              color: HexColor("#D9D9D9"),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              controller: _educationController,
                              minLines: 3,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Enter your education',
                                hintStyle: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Text(
                              "Experience",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Container(
                            width: 346,
                            height: 80,
                            decoration: BoxDecoration(
                              color: HexColor("#D9D9D9"),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              controller: _experienceController,
                              minLines: 3,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Enter your experience',
                                hintStyle: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Text(
                              "Projects",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Container(
                            width: 346,
                            height: 80,
                            decoration: BoxDecoration(
                              color: HexColor("#D9D9D9"),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              controller: _projectsController,
                              minLines: 3,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Enter your projects',
                                hintStyle: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, {
                                    'selectedWork': selectedWork.toList(),
                                    'selectedAvailability': selectedAvailability
                                        .toList(),
                                    'selectedLanguages': selectedLanguage
                                        .toList(),
                                    'customSkills': customSkills,
                                    'customLanguages': customLanguages,
                                    'bio': _bioController.text,
                                    'education': _educationController.text,
                                    'experience': _experienceController.text,
                                    'projects': _projectsController.text,
                                  });
                                },
                                child: Container(
                                  width: 130,
                                  height: 45,
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
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.save,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Save",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
          } else if (index == 1) {
          } else if (index == 2) {
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, Routes.workerSettings);
          }
        },
      ),
    );
  }

  void _addNewSkill() {
    TextEditingController skillController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Skill'),
          content: TextField(
            controller: skillController,
            decoration: const InputDecoration(
              hintText: 'Enter skill name',
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
                if (skillController.text.isNotEmpty) {
                  setState(() {
                    customSkills.add(skillController.text);
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

  void _addNewAvailability() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Availability'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: availabilityTypes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(availabilityTypes[index]),
                  onTap: () {
                    setState(() {
                      selectedAvailability.add(availabilityTypes[index]);
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
          ],
        );
      },
    );
  }
}
