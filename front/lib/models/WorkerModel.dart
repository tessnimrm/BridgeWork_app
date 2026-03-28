class WorkerProfile {
  final List<String> selectedWork;
  final List<String> selectedAvailability;
  final List<String> selectedLanguages;
  final List<String> customLanguages;
  final String bio;
  final Set<String> selectedSkills;
  final List<String> customSkills;

  WorkerProfile({
    required this.selectedWork,
    required this.selectedAvailability,
    required this.selectedLanguages,
    required this.selectedSkills,
    required this.customSkills,
    required this.customLanguages,
    required this.bio,
  });

  WorkerProfile copyWith({
    List<String>? selectedWork,
    List<String>? selectedAvailability,
    List<String>? selectedLanguages,
    Set<String>? selectedSkills,
    List<String>? customSkills,
    List<String>? customLanguages,
    String? bio,
  }) {
    return WorkerProfile(
      selectedWork: selectedWork ?? this.selectedWork,
      selectedAvailability: selectedAvailability ?? this.selectedAvailability,
      selectedLanguages: selectedLanguages ?? this.selectedLanguages,
      selectedSkills: selectedSkills ?? this.selectedSkills,
      customSkills: customSkills ?? this.customSkills,
      customLanguages: customLanguages ?? this.customLanguages,
      bio: bio ?? this.bio,
    );
  }
}
