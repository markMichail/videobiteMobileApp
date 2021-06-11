class Summary {
  int id;
  int videoId;
  String summary;
  String createdAt;

  Summary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoId = json['video_id'];
    summary = json['summary'];
    createdAt = json['created_at'];
  }
}
