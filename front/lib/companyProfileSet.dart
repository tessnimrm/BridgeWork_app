import 'package:BrigdeWork_app/profileCompany.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'background.dart';

class CompanyProfileSet extends StatefulWidget {
  const CompanyProfileSet({super.key});

  @override
  State<CompanyProfileSet> createState() => _CompanyProfileSetState();
}

class _CompanyProfileSetState extends State<CompanyProfileSet> {
  // تغيير من String? إلى Set<String> للسماح باختيار أكثر من skill
  Set<String> selectedWork = {};
  Set<String> selectedAvailability = {};
  Set<String> selectedLanguage = {};

  // إضافة متغير للتحكم في نص الـ Bio
  final TextEditingController _bioController = TextEditingController();

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
  List<String> Languages = ["English", "Arabic", "French"];
  List<String> customSkills = [];
  List<String> customLanguages = [];

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
                if (languageController.text.isNotEmpty) {
                  setState(() {
                    customLanguages.add(languageController.text);
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
    final itemWidth = (screenWidth - 40 - 30) / 4;

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
                child: Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "What kind of workers you're looking for?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            // المهارات الأساسية
                            ...workTypes.map((work) {
                              final isSelected = selectedWork.contains(work);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedWork.remove(work);
                                    } else {
                                      selectedWork.add(work);
                                    }
                                  });
                                },
                                child: Card(
                                  color: isSelected
                                      ? HexColor("#4F46E5")
                                      : HexColor("#D9D9D9"),
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    alignment: Alignment.center,
                                    child: Text(
                                      work,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
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

                            // المهارات المخصصة
                            ...customSkills.map((skill) {
                              final isSelected = selectedWork.contains(skill);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedWork.remove(skill);
                                    } else {
                                      selectedWork.add(skill);
                                    }
                                  });
                                },
                                child: Card(
                                  color: isSelected
                                      ? HexColor("#4F46E5")
                                      : HexColor("#D9D9D9"),
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    alignment: Alignment.center,
                                    child: Text(
                                      skill,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
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

                            // زر Add Skill
                            GestureDetector(
                              onTap: _addNewSkill,
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
                          spacing: 10,
                          runSpacing: 10,
                          children: availabilityTypes.map((availability) {
                            final isSelected = selectedAvailability.contains(
                              availability,
                            );
                            return SizedBox(
                              width: itemWidth,
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
                                        fontSize: 12,
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
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            // اللغات الأساسية
                            ...Languages.map((language) {
                              final isSelected = selectedLanguage.contains(
                                language,
                              );
                              return SizedBox(
                                width: itemWidth,
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
                                          fontSize: 12,
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

                            // اللغات المخصصة
                            ...customLanguages.map((language) {
                              final isSelected = selectedLanguage.contains(
                                language,
                              );
                              return SizedBox(
                                width: itemWidth,
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
                                          fontSize: 12,
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
                              width: itemWidth,
                              child: GestureDetector(
                                onTap: _addNewLanguage,
                                child: Card(
                                  color: HexColor("#D9D9D9"),
                                  child: Container(
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              hintText:
                                  'tell us more about your company , shop ,....',
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfileCompany(
                                          selectedWork: selectedWork.toList(),
                                          selectedAvailability:
                                              selectedAvailability.toList(),
                                          selectedLanguages: selectedLanguage
                                              .toList(),
                                          customSkills: customSkills,
                                          customLanguages: customLanguages,
                                          bio: _bioController.text,
                                        ),
                                      ),
                                    );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
