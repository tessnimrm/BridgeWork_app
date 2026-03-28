import 'package:flutter/material.dart';

class WorkerData {
  final String selectedJob;
  final List<String> selectedSkills;
  final List<String> selectedAvailability;
  final List<String> selectedLanguages;
  final List<String> customJobs;
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
    required this.selectedJob,
    required this.selectedSkills,
    required this.selectedAvailability,
    required this.selectedLanguages,
    required this.customJobs,
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
    String? selectedJob,
    List<String>? selectedSkills,
    List<String>? selectedAvailability,
    List<String>? selectedLanguages,
    List<String>? customJobs,
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
      selectedJob: selectedJob ?? this.selectedJob,
      selectedSkills: selectedSkills ?? this.selectedSkills,
      selectedAvailability: selectedAvailability ?? this.selectedAvailability,
      selectedLanguages: selectedLanguages ?? this.selectedLanguages,
      customJobs: customJobs ?? this.customJobs,
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
    required String selectedJob,
    required List<String> selectedSkills,
    required List<String> selectedAvailability,
    required List<String> selectedLanguages,
    required List<String> customJobs,
    required List<String> customLanguages,
    String bio = '',
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
      selectedJob: selectedJob,
      selectedSkills: selectedSkills,
      selectedAvailability: selectedAvailability,
      selectedLanguages: selectedLanguages,
      customJobs: customJobs,
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
    String? selectedJob,
    List<String>? selectedSkills,
    List<String>? selectedAvailability,
    List<String>? selectedLanguages,
    List<String>? customJobs,
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
        selectedJob: selectedJob,
        selectedSkills: selectedSkills,
        selectedAvailability: selectedAvailability,
        selectedLanguages: selectedLanguages,
        customJobs: customJobs,
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
    } else {
      // إذا كان _workerData null، قم بإنشاء بيانات جديدة
      _workerData = WorkerData(
        selectedJob: selectedJob ?? '',
        selectedSkills: selectedSkills ?? [],
        selectedAvailability: selectedAvailability ?? [],
        selectedLanguages: selectedLanguages ?? [],
        customJobs: customJobs ?? [],
        customLanguages: customLanguages ?? [],
        bio: bio ?? '',
        education: education ?? '',
        experience: experience ?? '',
        projects: projects ?? '',
        fullName: fullName ?? '',
        email: email ?? '',
        phone: phone ?? '',
        coverImagePath: coverImagePath ?? '',
        profileImagePath: profileImagePath ?? '',
      );
      notifyListeners();
    }
  }

  void updateWorkerData({
    String? selectedJob,
    List<String>? selectedSkills,
    List<String>? selectedAvailability,
    List<String>? selectedLanguages,
    List<String>? customJobs,
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
        selectedJob: selectedJob ?? _workerData!.selectedJob,
        selectedSkills: selectedSkills ?? _workerData!.selectedSkills,
        selectedAvailability:
            selectedAvailability ?? _workerData!.selectedAvailability,
        selectedLanguages: selectedLanguages ?? _workerData!.selectedLanguages,
        customJobs: customJobs ?? _workerData!.customJobs,
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
