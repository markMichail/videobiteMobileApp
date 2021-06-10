class HomeModel {
  bool status;
  String message;
  HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  int currentPage;
  List<HomeVideoDataModel> videos = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      videos.add(HomeVideoDataModel.fromJson(element));
    });
  }
}

class HomeVideoDataModel {
  int id;
  int userId;
  String title;
  String link;
  int flag;
  int activeSummary;
  String createdAt;
  HomeVideoDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    link = json['link'];
    flag = json['flag'];
    activeSummary = json['active_summary'];
    createdAt = json['created_at'];
  }
}
