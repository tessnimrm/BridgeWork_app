import 'package:flutter/material.dart';

class WorkerData {
  final List<String> selectedWork;
  final List<String> selectedAvailability;
  final List<String> selectedLanguages;
  final List<String> customSkills;
  final List<String> customLanguages;
  final String bio;
  final String education;
  final String experience;
  final String projects;
  final String fullName;
  final String email;
  final String phone;
  final String coverImagePath;
  final String profileImagePath;

  WorkerData({
    required this.selectedWork,
    required this.selectedAvailability,
    required this.selectedLanguages,
    required this.customSkills,
    required this.customLanguages,
    this.bio = '',
    required this.education,
    required this.experience,
    required this.projects,
    required this.fullName,
    required this.email,
    this.phone = '',
    required this.coverImagePath,
    required this.profileImagePath,
  });

  WorkerData copyWith({
    List<String>? selectedWork,
    List<String>? selectedAvailability,
    List<String>? selectedLanguages,
    List<String>? customSkills,
    List<String>? customLanguages,
    String? bio,
    String? education,
    String? experience,
    String? projects,
    String? fullName,
    String? email,
    String? phone,
    String? coverImagePath,
    String? profileImagePath,
  }) {
    return WorkerData(
      selectedWork: selectedWork ?? this.selectedWork,
      selectedAvailability: selectedAvailability ?? this.selectedAvailability,
      selectedLanguages: selectedLanguages ?? this.selectedLanguages,
      customSkills: customSkills ?? this.customSkills,
      customLanguages: customLanguages ?? this.customLanguages,
      bio: bio ?? this.bio,
      education: education ?? this.education,
      experience: experience ?? this.experience,
      projects: projects ?? this.projects,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }
}

class WorkerProvider extends ChangeNotifier {
  WorkerData? _workerData;

  WorkerData? get workerData => _workerData;

  void createProfile({
    required List<String> selectedWork,
    required List<String> selectedAvailability,
    required List<String> selectedLanguages,
    required List<String> customSkills,
    required List<String> customLanguages,
    /*required*/ String bio = '',
    String education = '',
    String experience = '',
    String projects = '',
    String phone = '',
    required String fullName,
    required String email,
    String coverImagePath = '',
    String profileImagePath = '',
  }) {
    _workerData = WorkerData(
      selectedWork: selectedWork,
      selectedAvailability: selectedAvailability,
      selectedLanguages: selectedLanguages,
      customSkills: customSkills,
      customLanguages: customLanguages,
      bio: bio,
      education: education,
      experience: experience,
      projects: projects,
      fullName: fullName,
      email: email,
      phone: phone,
      coverImagePath: coverImagePath,
      profileImagePath: profileImagePath,
    );
    notifyListeners();
  }

  void updateProfile({
    List<String>? selectedWork,
    List<String>? selectedAvailability,
    List<String>? selectedLanguages,
    List<String>? customSkills,
    List<String>? customLanguages,
    String? bio,
    String? education,
    String? experience,
    String? projects,
    String? fullName,
    String? email,
    String? phone,
    String? coverImagePath,
    String? profileImagePath,
  }) {
    if (_workerData != null) {
      _workerData = _workerData!.copyWith(
        selectedWork: selectedWork,
        selectedAvailability: selectedAvailability,
        selectedLanguages: selectedLanguages,
        customSkills: customSkills,
        customLanguages: customLanguages,
        bio: bio,
        education: education,
        experience: experience,
        projects: projects,
        fullName: fullName,
        email: email,
        phone: phone,
        coverImagePath: coverImagePath,
        profileImagePath: profileImagePath,
      );
      notifyListeners();
    }
  }

  void updateWorkerData({
    List<String>? selectedWork,
    List<String>? selectedAvailability,
    List<String>? selectedLanguages,
    List<String>? customSkills,
    List<String>? customLanguages,
    String? bio,
    String? education,
    String? experience,
    String? projects,
    String? fullName,
    String? email,
    String? phone,
    String? coverImagePath,
    String? profileImagePath,
  }) {
    if (_workerData != null) {
      _workerData = WorkerData(
        selectedWork: selectedWork ?? _workerData!.selectedWork,
        selectedAvailability:
            selectedAvailability ?? _workerData!.selectedAvailability,
        selectedLanguages: selectedLanguages ?? _workerData!.selectedLanguages,
        customSkills: customSkills ?? _workerData!.customSkills,
        customLanguages: customLanguages ?? _workerData!.customLanguages,
        bio: bio ?? _workerData!.bio,
        education: education ?? _workerData!.education,
        experience: experience ?? _workerData!.experience,
        projects: projects ?? _workerData!.projects,
        fullName: fullName ?? _workerData!.fullName,
        email: email ?? _workerData!.email,
        phone: phone ?? _workerData!.phone,
        coverImagePath: coverImagePath ?? _workerData!.coverImagePath,
        profileImagePath: profileImagePath ?? _workerData!.profileImagePath,
      );
      notifyListeners();
    }
  }

  void clearProfile() {
    _workerData = null;
    notifyListeners();
  }

  bool get hasProfile => _workerData != null;
}
