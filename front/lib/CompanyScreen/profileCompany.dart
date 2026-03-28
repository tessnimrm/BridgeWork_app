import 'package:brigdeWork_app/CompanyScreen/bottomBarCompany.dart';
import 'package:brigdeWork_app/shared_pages/background.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:brigdeWork_app/shared_pages/Routes.dart';
import 'package:brigdeWork_app/providers/CompanyProvider.dart';
import 'package:provider/provider.dart';
import 'package:brigdeWork_app/CompanyScreen/companyProfileSet.dart';
import 'dart:io';

class ProfileCompany extends StatefulWidget {
  const ProfileCompany({super.key});

  @override
  State<ProfileCompany> createState() => _ProfileCompanyState();
}

class _ProfileCompanyState extends State<ProfileCompany> {
  bool isSkillsVisible = false;
  bool isServicesVisible = false;
  bool isOverviewVisible = false;

  @override
  Widget build(BuildContext context) {
    final companyProvider = Provider.of<CompanyProvider>(context);
    final data = companyProvider.companyData;

    if (data == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CompanyProfileSet()),
        );
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final coverImage = data.coverImagePath.isNotEmpty
        ? FileImage(File(data.coverImagePath))
        : const AssetImage('lib/images/photo_1.jpg') as ImageProvider;
    final logoImage = data.logoImagePath.isNotEmpty
        ? FileImage(File(data.logoImagePath))
        : const AssetImage('lib/images/photo_2.jpg') as ImageProvider;

    final allSkills = <String>[];
    if (data.requiredSkills != null && data.requiredSkills.isNotEmpty) {
      allSkills.addAll(data.requiredSkills);
    }

    final allAvailability = <String>[];
    if (data.selectedAvailabilities.isNotEmpty) {
      allAvailability.addAll(data.selectedAvailabilities);
    }

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
                                    image: logoImage,
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
                              data.companyName.isNotEmpty
                                  ? data.companyName
                                  : 'COMPANY NAME',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // المجال اللي اختاره
                            Text(
                              data.selectedIndustry.isNotEmpty
                                  ? data.selectedIndustry
                                  : 'No industry selected',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
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
                                                    "Skills Needed",
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
                                                  "No skills added yet",
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
                                              if (allAvailability.isNotEmpty)
                                                Wrap(
                                                  spacing: 4,
                                                  children: allAvailability.map((
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
                                                )
                                              else
                                                const Text(
                                                  "No availability selected",
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
                                                Icons.info_outline,
                                                size: 16,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                "About Us",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            data.description.isEmpty
                                                ? "No description added"
                                                : data.description,
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
                              title: "Services",
                              isVisible: isServicesVisible,
                              onTap: () {
                                setState(() {
                                  isServicesVisible = !isServicesVisible;
                                });
                              },
                            ),
                            if (isServicesVisible)
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        if (data.services.isNotEmpty)
                                          Text(
                                            data.services,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              height: 1.5,
                                            ),
                                          )
                                        else
                                          const Text(
                                            "No services added yet",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        if (data
                                            .customIndustries
                                            .isNotEmpty) ...[
                                          const SizedBox(height: 12),
                                          const Text(
                                            "Custom Services:",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: data.customIndustries.map((
                                              service,
                                            ) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: HexColor("#D9D9D9"),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  service,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 12),
                            _buildMainCard(
                              title: "Achievement",
                              isVisible: isSkillsVisible,
                              onTap: () {
                                setState(() {
                                  isSkillsVisible = !isSkillsVisible;
                                });
                              },
                            ),
                            if (isSkillsVisible)
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        if (data.achievements.isNotEmpty)
                                          Text(
                                            data.achievements,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              height: 1.5,
                                            ),
                                          )
                                        else
                                          const Text(
                                            "No achievements added yet",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 12),
                            _buildMainCard(
                              title: "Company Overview",
                              isVisible: isOverviewVisible,
                              onTap: () {
                                setState(() {
                                  isOverviewVisible = !isOverviewVisible;
                                });
                              },
                            ),
                            if (isOverviewVisible)
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // ✅ عرض Company Overview أولاً
                                        if (data
                                            .companyOverview
                                            .isNotEmpty) ...[
                                          const SizedBox(height: 8),
                                          Text(
                                            data.companyOverview,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              height: 1.5,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                        ],
                                        if (data.website.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 8,
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.link,
                                                  size: 14,
                                                  color: Colors.grey,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  data.website,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (data.address.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 8,
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  size: 14,
                                                  color: Colors.grey,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  data.address,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (data.phone.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 8,
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.phone,
                                                  size: 14,
                                                  color: Colors.grey,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  data.phone,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (data.email.isNotEmpty)
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.email,
                                                size: 14,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                data.email,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (data.companyOverview.isEmpty &&
                                            data.website.isEmpty &&
                                            data.address.isEmpty &&
                                            data.phone.isEmpty &&
                                            data.email.isEmpty)
                                          const Text(
                                            "No company overview added yet",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                      ],
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
      bottomNavigationBar: CustomBottomBarCompany(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, Routes.Hire);
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, Routes.MessagesPage);
          } else if (index == 2) {
            // Already on profile
          } else if (index == 3) {
            Navigator.pushNamed(context, Routes.companySettings);
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
