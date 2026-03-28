// providers/LikedJobsProvider.dart
import 'package:flutter/material.dart';
import '../models/JobModel.dart';

class LikedJobsProvider extends ChangeNotifier {
  List<JobModel> _likedJobs = [];

  List<JobModel> get likedJobs => _likedJobs;

  void addJob(JobModel job) {
    if (!_likedJobs.any((j) => j.title == job.title && j.place == job.place)) {
      _likedJobs.add(job);
      notifyListeners();
    }
  }

  void removeJob(JobModel job) {
    _likedJobs.removeWhere((j) => j.title == job.title && j.place == job.place);
    notifyListeners();
  }

  bool isLiked(JobModel job) {
    return _likedJobs.any((j) => j.title == job.title && j.place == job.place);
  }

  void clearLikedJobs() {
    _likedJobs.clear();
    notifyListeners();
  }
}
