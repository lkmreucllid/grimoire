class OpenFeedModel {
  String feedId;
  int likes;
  String categoryId;
  String categoryName;
  String title;
  String bodyText;
  String userId;
  String userName;
  String createdDate;
  String updatedDate;
  bool isLiked;

  OpenFeedModel({
    this.feedId,
    this.likes,
    this.categoryId,
    this.categoryName,
    this.title,
    this.bodyText,
    this.userId,
    this.userName,
    this.createdDate,
    this.updatedDate,
    this.isLiked,
  });

  OpenFeedModel.fromJson(Map<String, dynamic> json) {
    feedId = json['data']['_id'];
    likes = json['data']['totalLikes'];
    categoryId = json['data']['category']['_id'];
    categoryName = json['data']['category']['name'];
    title = json['data']['title'];
    bodyText = json['data']['body'];
    userId = json['data']['user']['_id'];
    userName = json['data']['user']['name'];
    createdDate = json['data']['createdAt'];
    updatedDate = json['data']['updatedAt'];
    isLiked = json['data']['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feedId'] = this.feedId;
    data['likes'] = this.likes;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['title'] = this.title;
    data['bodyText'] = this.bodyText;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['isLiked'] = this.isLiked;
    return data;
  }
}
