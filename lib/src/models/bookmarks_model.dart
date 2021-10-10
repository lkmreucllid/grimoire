class BookmarksModel {
  bool success;
  String message;
  List<BookmarkList> data;

  BookmarksModel({
    this.success,
    this.message,
    this.data,
  });

  BookmarksModel.fromJson(Map<String, dynamic> json) {
    success = json['sucess'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new BookmarkList.fromJson(v));
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

class BookmarkList {
  String bookMarkId;
  String feedId;
  String title;
  String body;
  String categoryName;

  BookmarkList({
    this.bookMarkId,
    this.feedId,
    this.title,
    this.body,
    this.categoryName,
  });

  BookmarkList.fromJson(Map<String, dynamic> json) {
    bookMarkId = json['_id'];
    feedId = json['post']['_id'];
    title = json['post']['title'];
    body = json['post']['body'];
    categoryName = json['post']['category']['_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookMarkId'] = this.bookMarkId;
    data['feedId'] = this.feedId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['categoryName'] = this.categoryName;
    return data;
  }
}
