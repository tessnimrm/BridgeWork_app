// lib/models/WorkerModel.dart
import 'package:flutter/material.dart';

class WorkerModel extends ChangeNotifier {
  // البيانات الأساسية
  String _fullName = 'YOUR FULL NAME';
  String _jobTitle = 'UI/UX Designer';
  String _profileImage = 'lib/images/photo_2.jpg';
  String _coverImage = 'lib/images/photo_1.jpg';

  // بيانات المهارات والتوفر
  List<String> _skills = [];
  List<String> _availability = [];
  List<String> _languages = [];
  List<String> _customSkills = [];
  List<String> _customLanguages = [];

  // بيانات النصوص
  String _bio = '';
  String _education = '';
  String _experience = '';
  String _projects = '';

  // Getters
  String get fullName => _fullName;
  String get jobTitle => _jobTitle;
  String get profileImage => _profileImage;
  String get coverImage => _coverImage;
  List<String> get skills => List.unmodifiable(_skills);
  List<String> get availability => List.unmodifiable(_availability);
  List<String> get languages => List.unmodifiable(_languages);
  List<String> get customSkills => List.unmodifiable(_customSkills);
  List<String> get customLanguages => List.unmodifiable(_customLanguages);
  String get bio => _bio;
  String get education => _education;
  String get experience => _experience;
  String get projects => _projects;

  // Setters مع notifyListeners()
  void updateBasicInfo({String? fullName, String? jobTitle}) {
    if (fullName != null) _fullName = fullName;
    if (jobTitle != null) _jobTitle = jobTitle;
    notifyListeners();
  }

  void updateProfileImage(String imagePath) {
    _profileImage = imagePath;
    notifyListeners();
  }

  void updateCoverImage(String imagePath) {
    _coverImage = imagePath;
    notifyListeners();
  }

  void updateAllData({
    List<String>? skills,
    List<String>? availability,
    List<String>? languages,
    List<String>? customSkills,
    List<String>? customLanguages,
    String? bio,
    String? education,
    String? experience,
    String? projects,
  }) {
    if (skills != null) _skills = skills;
    if (availability != null) _availability = availability;
    if (languages != null) _languages = languages;
    if (customSkills != null) _customSkills = customSkills;
    if (customLanguages != null) _customLanguages = customLanguages;
    if (bio != null) _bio = bio;
    if (education != null) _education = education;
    if (experience != null) _experience = experience;
    if (projects != null) _projects = projects;

    notifyListeners();
  }
}
