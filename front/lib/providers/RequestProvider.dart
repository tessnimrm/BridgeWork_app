// providers/RequestsProvider.dart
import 'package:flutter/material.dart';
import '../models/RequestModel.dart';

class RequestsProvider extends ChangeNotifier {
  List<RequestModel> _requests = [];
  List<RequestModel> _receivedRequests = [];

  List<RequestModel> get requests => _requests;
  List<RequestModel> get receivedRequests => _receivedRequests;

  void sendRequest(RequestModel request) {
    _requests.add(request);
    notifyListeners();
  }

  void receiveRequest(RequestModel request) {
    _receivedRequests.add(request);
    notifyListeners();
  }

  String getRequestStatus(String userId) {
    final request = _receivedRequests.firstWhere(
      (r) => r.id == userId,
      orElse: () => RequestModel(
        id: '',
        jobTitle: '',
        workerName: '',
        workerImage: '',
        status: 'none',
        date: DateTime.now(),
      ),
    );
    return request.status;
  }

  void updateRequestStatus(String id, String status) {
    final index = _receivedRequests.indexWhere((r) => r.id == id);
    if (index != -1) {
      _receivedRequests[index].status = status;
      notifyListeners();
    }
  }

  void acceptRequest(String id) {
    updateRequestStatus(id, 'accepted');
  }
}
