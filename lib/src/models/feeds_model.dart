class FeedsModel {
  bool success;
  String message;
  List<FeedsList> data;

  FeedsModel({
    this.success,
    this.message,
    this.data,
  });

  FeedsModel.fromJson(Map<String, dynamic> json) {
    success = json['sucess'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new FeedsList.fromJson(v));
        data.add(new FeedsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sucess'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class FeedsList {
  String feedId;
  int likes;
  String categoryId;
  String categoryName;
  String categoryIconURL;
  String title;
  String bodyText;
  String userId;
  String userName;
  String createdDate;
  String updatedDate;

  FeedsList({
    this.feedId,
    this.likes,
    this.categoryId,
    this.categoryName,
    this.categoryIconURL,
    this.title,
    this.bodyText,
    this.userId,
    this.userName,
    this.createdDate,
    this.updatedDate,
  });

  FeedsList.fromJson(Map<String, dynamic> json) {
    feedId = json['_id'];
    likes = json['likes'];
    categoryId = json['category']['_id'];
    categoryName = json['category']['name'];
    categoryIconURL = json['category']['url'];
    title = json['title'];
    bodyText = json['body'];
    userId = json['user']['_id'];
    userName = json['user']['name'];
    createdDate = json['createdAt'];
    updatedDate = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feedId'] = this.feedId;
    data['likes'] = this.likes;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['categoryIconURL'] = this.categoryIconURL;
    data['title'] = this.title;
    data['bodyText'] = this.bodyText;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}
