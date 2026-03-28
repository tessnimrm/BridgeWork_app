import 'package:brigdeWork_app/CompanyScreen/profileCompany.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../shared_pages/background.dart';
import 'package:provider/provider.dart';
import '../models/CompanyModel.dart';
import '../providers/CompanyProvider.dart';

class CompanyProfileSet extends StatefulWidget {
  const CompanyProfileSet({super.key});

  @override
  State<CompanyProfileSet> createState() => _CompanyProfileSetState();
}

class _CompanyProfileSetState extends State<CompanyProfileSet> {
  String? selectedIndustry;
  Set<String> selectedAvailability = {};
  Set<String> selectedLanguages = {};
  final TextEditingController _descriptionController = TextEditingController();

  List<String> customIndustries = [];
  List<String> customLanguages = [];

  List<String> industryTypes = [
    "Cooking",
    "Waiter",
    "Delivery",
    "UI/UX Design",
  ];

  List<String> Availability = [
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
    if (selectedIndustry == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select your company industry'),
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
          content: const Text('Please select at least one availability choice'),
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

    if (selectedLanguages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select at least one language'),
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

  void _addNewIndustry() {
    TextEditingController industryController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Industry'),
          content: TextField(
            controller: industryController,
            decoration: const InputDecoration(
              hintText: 'Enter industry name',
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
                String newIndustry = industryController.text.trim();

                if (newIndustry.isNotEmpty) {
                  setState(() {
                    if (!customIndustries.contains(newIndustry)) {
                      customIndustries.add(newIndustry);
                    }
                    selectedIndustry = newIndustry;
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
                    selectedLanguages.add(newLanguage);
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
                  "Set up your company profile",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                child: const Text(
                  "Tell us about your company. You can edit this later.",
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
                      // مجال الشركة (جبري)
                      const Text(
                        "What industry does your company operate in?",
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
                          ...industryTypes.map((industry) {
                            final isSelected = selectedIndustry == industry;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedIndustry = null;
                                  } else {
                                    selectedIndustry = industry;
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
                                    industry,
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

                          ...customIndustries.map((industry) {
                            final isSelected = selectedIndustry == industry;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedIndustry = null;
                                  } else {
                                    selectedIndustry = industry;
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
                                    industry,
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

                          GestureDetector(
                            onTap: _addNewIndustry,
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

                      // أوقات العمل (جبري)
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
                        children: Availability.map((availability) {
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

                      // لغة التواصل (جبري)
                      const Text(
                        "Communication language",
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
                          ...Languages.map((language) {
                            final isSelected = selectedLanguages.contains(
                              language,
                            );
                            return SizedBox(
                              width: (screenWidth - 40 - 36) / 4,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedLanguages.remove(language);
                                    } else {
                                      selectedLanguages.add(language);
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
                            final isSelected = selectedLanguages.contains(
                              language,
                            );
                            return SizedBox(
                              width: (screenWidth - 40 - 36) / 4,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedLanguages.remove(language);
                                    } else {
                                      selectedLanguages.add(language);
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

                      // البايو (اختياري)
                      const Text(
                        "Short bio (Optional)",
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
                          controller: _descriptionController,
                          maxLines: 5,
                          minLines: 3,
                          decoration: InputDecoration(
                            hintText:
                                'Tell us about your company, mission, values...',
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
                                    final companyProvider =
                                        Provider.of<CompanyProvider>(
                                          context,
                                          listen: false,
                                        );

                                    final existingData =
                                        companyProvider.companyData;

                                    if (existingData != null) {
                                      companyProvider.updateProfile(
                                        selectedIndustry: selectedIndustry!,
                                        selectedAvailabilities:
                                            selectedAvailability.toList(),
                                        selectedLanguages: selectedLanguages
                                            .toList(),
                                        customIndustries: customIndustries,
                                        customLanguages: customLanguages,
                                        description:
                                            _descriptionController.text,
                                        companyName: existingData.companyName,
                                        email: existingData.email,
                                        phone: existingData.phone,
                                        website: existingData.website,
                                        coverImagePath:
                                            existingData.coverImagePath,
                                        logoImagePath:
                                            existingData.logoImagePath,
                                      );
                                    } else {
                                      companyProvider.createProfile(
                                        selectedIndustry: selectedIndustry!,
                                        selectedAvailabilities:
                                            selectedAvailability.toList(),
                                        requiredSkills: [],
                                        selectedLanguages: selectedLanguages
                                            .toList(),
                                        customIndustries: customIndustries,
                                        customLanguages: customLanguages,
                                        description:
                                            _descriptionController.text,
                                        companyName: '',
                                        email: '',
                                        services: '',
                                        achievements: '',
                                        companyOverview: '',
                                      );
                                    }

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileCompany(),
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
