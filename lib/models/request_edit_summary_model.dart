import 'package:videobite/models/summary_model.dart';

class RequestEditSummaryModel {
  bool status;
  String message;
  Summary summary;

  RequestEditSummaryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (message == "allowed")
      summary =
          json['data'] != null ? new Summary.fromJson(json['data']) : null;
  }
}
