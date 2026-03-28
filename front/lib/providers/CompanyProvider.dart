// providers/CompanyProvider.dart
import 'package:flutter/material.dart';
import '../models/CompanyModel.dart';

class CompanyProvider extends ChangeNotifier {
  CompanyData? _companyData;

  CompanyData? get companyData => _companyData;

  void createProfile({
    required String selectedIndustry,
    required List<String> selectedAvailabilities,
    required List<String> requiredSkills,
    required List<String> selectedLanguages,
    required List<String> customIndustries,
    required List<String> customLanguages,
    String description = '',
    required String companyName,
    required String email,
    String phone = '',
    String website = '',
    String coverImagePath = '',
    String logoImagePath = '',
    String address = '',
    int employeeCount = 0,
    String services = '',
    String achievements = '',
    String companyOverview = '',
  }) {
    _companyData = CompanyData(
      selectedIndustry: selectedIndustry,
      selectedAvailabilities: selectedAvailabilities,
      requiredSkills: requiredSkills,
      selectedLanguages: selectedLanguages,
      customIndustries: customIndustries,
      customLanguages: customLanguages,
      description: description,
      companyName: companyName,
      email: email,
      phone: phone,
      website: website,
      coverImagePath: coverImagePath,
      logoImagePath: logoImagePath,
      address: address,
      employeeCount: employeeCount,
      services: services,
      achievements: achievements,
      companyOverview: companyOverview,
    );
    notifyListeners();
  }

  void updateProfile({
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
    if (_companyData != null) {
      _companyData = _companyData!.copyWith(
        selectedIndustry: selectedIndustry,
        selectedAvailabilities: selectedAvailabilities,
        requiredSkills: requiredSkills,
        selectedLanguages: selectedLanguages,
        customIndustries: customIndustries,
        customLanguages: customLanguages,
        description: description,
        companyName: companyName,
        email: email,
        phone: phone,
        website: website,
        coverImagePath: coverImagePath,
        logoImagePath: logoImagePath,
        address: address,
        employeeCount: employeeCount,
        services: services,
        achievements: achievements,
        companyOverview: companyOverview,
      );
      notifyListeners();
    } else {
      _companyData = CompanyData(
        selectedIndustry: selectedIndustry ?? '',
        selectedAvailabilities: selectedAvailabilities ?? [],
        requiredSkills: requiredSkills ?? [],
        selectedLanguages: selectedLanguages ?? [],
        customIndustries: customIndustries ?? [],
        customLanguages: customLanguages ?? [],
        description: description ?? '',
        companyName: companyName ?? '',
        email: email ?? '',
        phone: phone ?? '',
        website: website ?? '',
        coverImagePath: coverImagePath ?? '',
        logoImagePath: logoImagePath ?? '',
        address: address ?? '',
        employeeCount: employeeCount ?? 0,
        services: services ?? '',
        achievements: achievements ?? '',
        companyOverview: companyOverview ?? '',
      );
      notifyListeners();
    }
  }

  void updateCompanyData({
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
    if (_companyData != null) {
      _companyData = CompanyData(
        selectedIndustry: selectedIndustry ?? _companyData!.selectedIndustry,
        selectedAvailabilities:
            selectedAvailabilities ?? _companyData!.selectedAvailabilities,
        requiredSkills: requiredSkills ?? _companyData!.requiredSkills,
        selectedLanguages: selectedLanguages ?? _companyData!.selectedLanguages,
        customIndustries: customIndustries ?? _companyData!.customIndustries,
        customLanguages: customLanguages ?? _companyData!.customLanguages,
        description: description ?? _companyData!.description,
        companyName: companyName ?? _companyData!.companyName,
        email: email ?? _companyData!.email,
        phone: phone ?? _companyData!.phone,
        website: website ?? _companyData!.website,
        coverImagePath: coverImagePath ?? _companyData!.coverImagePath,
        logoImagePath: logoImagePath ?? _companyData!.logoImagePath,
        address: address ?? _companyData!.address,
        employeeCount: employeeCount ?? _companyData!.employeeCount,
        services: services ?? _companyData!.services,
        achievements: achievements ?? _companyData!.achievements,
        companyOverview: companyOverview ?? _companyData!.companyOverview,
      );
      notifyListeners();
    }
  }

  void clearProfile() {
    _companyData = null;
    notifyListeners();
  }

  bool get hasProfile => _companyData != null;
}
