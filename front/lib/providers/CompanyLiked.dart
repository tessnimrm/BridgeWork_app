// providers/company_liked_workers_provider.dart
import 'package:flutter/material.dart';
import '../models/JobModel.dart';

class CompanyLikedWorkersProvider extends ChangeNotifier {
  List<JobModel> _likedWorkers = [];

  List<JobModel> get likedWorkers => _likedWorkers;

  void addWorker(JobModel worker) {
    if (!_likedWorkers.any(
      (w) => w.title == worker.title && w.place == worker.place,
    )) {
      _likedWorkers.add(worker);
      notifyListeners();
    }
  }

  void removeWorker(JobModel worker) {
    _likedWorkers.removeWhere(
      (w) => w.title == worker.title && w.place == worker.place,
    );
    notifyListeners();
  }

  bool isLiked(JobModel worker) {
    return _likedWorkers.any(
      (w) => w.title == worker.title && w.place == worker.place,
    );
  }

  void clearLikedWorkers() {
    _likedWorkers.clear();
    notifyListeners();
  }
}
