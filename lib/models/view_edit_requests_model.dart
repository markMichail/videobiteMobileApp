class ViewEditRequestsModel {
  bool status;
  String message;
  List<RequestData> requests = [];

  ViewEditRequestsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    json['data'].forEach((element) {
      requests.add(RequestData.fromJson(element));
    });
  }
}

class RequestData {
  int summaryId;
  int videoId;
  String summary;
  String status;
  String createdAt;
  RequestData.fromJson(Map<String, dynamic> json) {
    summaryId = json['summary_id'];
    videoId = json['video_id'];
    summary = json['summary'];
    status = json['status'];
    createdAt = json['created_t'];
  }
}
