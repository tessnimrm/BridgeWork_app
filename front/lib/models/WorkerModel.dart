// models.dart
class WorkerProfile {
  final List<String> selectedWork;
  final List<String> selectedAvailability;
  final List<String> selectedLanguages;
  final List<String> customSkills;
  final List<String> customLanguages;
  final String bio;

  WorkerProfile({
    required this.selectedWork,
    required this.selectedAvailability,
    required this.selectedLanguages,
    required this.customSkills,
    required this.customLanguages,
    required this.bio,
  });

  // دالة مساعدة لنسخ البيانات (مفيدة للتحديث)
  WorkerProfile copyWith({
    List<String>? selectedWork,
    List<String>? selectedAvailability,
    List<String>? selectedLanguages,
    List<String>? customSkills,
    List<String>? customLanguages,
    String? bio,
  }) {
    return WorkerProfile(
      selectedWork: selectedWork ?? this.selectedWork,
      selectedAvailability: selectedAvailability ?? this.selectedAvailability,
      selectedLanguages: selectedLanguages ?? this.selectedLanguages,
      customSkills: customSkills ?? this.customSkills,
      customLanguages: customLanguages ?? this.customLanguages,
      bio: bio ?? this.bio,
    );
  }
}
