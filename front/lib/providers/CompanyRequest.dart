// providers/company_requests_provider.dart
import 'package:flutter/material.dart';
import '../models/RequestModel.dart';

class CompanyRequestsProvider extends ChangeNotifier {
  List<RequestModel> _sentRequests = [];
  List<RequestModel> _receivedRequests = [];

  List<RequestModel> get sentRequests => _sentRequests;
  List<RequestModel> get receivedRequests => _receivedRequests;

  void sendRequest(RequestModel request) {
    _sentRequests.add(request);
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

    // Also update in sent requests if needed
    final sentIndex = _sentRequests.indexWhere((r) => r.id == id);
    if (sentIndex != -1) {
      _sentRequests[sentIndex].status = status;
      notifyListeners();
    }
  }

  void acceptRequest(String id) {
    updateRequestStatus(id, 'accepted');
  }

  void rejectRequest(String id) {
    updateRequestStatus(id, 'rejected');
  }
}
