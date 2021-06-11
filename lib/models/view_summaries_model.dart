import 'package:videobite/models/summary_model.dart';

class ViewSummariesModel {
  bool status;
  String message;
  int activeSummaryId;
  List<Summary> data = [];

  ViewSummariesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    activeSummaryId = json['data']['active_summary_id'];
    if (json['data']['summaries'] != null)
      json['data']['summaries'].forEach((element) {
        data.add(Summary.fromJson(element));
      });
  }
}
