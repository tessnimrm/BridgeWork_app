// models/CompanyModel.dart
class CompanyData {
  final String selectedIndustry;
  final List<String> selectedAvailabilities;
  final List<String> requiredSkills;
  final List<String> selectedLanguages;
  final List<String> customIndustries;
  final List<String> customLanguages;
  final String description;
  final String companyName;
  final String email;
  final String phone;
  final String website;
  final String coverImagePath;
  final String logoImagePath;
  final String address;
  final int employeeCount;
  final String services;
  final String achievements;
  final String companyOverview;

  CompanyData({
    required this.selectedIndustry,
    required this.selectedAvailabilities,
    required this.requiredSkills,
    required this.selectedLanguages,
    required this.customIndustries,
    required this.customLanguages,
    required this.description,
    required this.companyName,
    required this.email,
    required this.phone,
    required this.website,
    required this.coverImagePath,
    required this.logoImagePath,
    required this.address,
    required this.employeeCount,
    required this.services,
    required this.achievements,
    required this.companyOverview,
  });

  CompanyData copyWith({
    String? selectedIndustry,
    List<String>? selectedAvailabilities,
    List<String>? requiredSkills,
    List<String>? selectedLanguages,
    List<String>? customIndustries,
    List<String>? customLanguages,
    String? description,
    String? companyName,
    String? email,
    String? phone,
    String? website,
    String? coverImagePath,
    String? logoImagePath,
    String? address,
    int? employeeCount,
    String? services,
    String? achievements,
    String? companyOverview,
  }) {
    return CompanyData(
      selectedIndustry: selectedIndustry ?? this.selectedIndustry,
      selectedAvailabilities:
          selectedAvailabilities ?? this.selectedAvailabilities,
      requiredSkills: requiredSkills ?? this.requiredSkills,
      selectedLanguages: selectedLanguages ?? this.selectedLanguages,
      customIndustries: customIndustries ?? this.customIndustries,
      customLanguages: customLanguages ?? this.customLanguages,
      description: description ?? this.description,
      companyName: companyName ?? this.companyName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      logoImagePath: logoImagePath ?? this.logoImagePath,
      address: address ?? this.address,
      employeeCount: employeeCount ?? this.employeeCount,
      services: services ?? this.services,
      achievements: achievements ?? this.achievements,
      companyOverview: companyOverview ?? this.companyOverview,
    );
  }
}
