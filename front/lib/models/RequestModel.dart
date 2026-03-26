// models/RequestModel.dart
class RequestModel {
  final String id;
  final String jobTitle;
  final String workerName;
  final String workerImage;
  String status;
  final DateTime date;

  RequestModel({
    required this.id,
    required this.jobTitle,
    required this.workerName,
    required this.workerImage,
    this.status = 'pending',
    required this.date,
  });
}
