class HistoryModel {
  bool status;
  String message;
  List<HistoryData> data = [];

  HistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    json['data'].forEach((element) {
      data.add(HistoryData.fromJson(element));
    });
  }
}

class HistoryData {
  int id;
  int userId;
  String title;
  String link;
  int flag;
  int activeSummary;
  String createdAt;

  HistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    link = json['link'];
    flag = json['flag'];
    activeSummary = json['active_summary'];
    createdAt = json['created_at'];
  }
}
