class SelectCategoryModel {
  bool success;
  String message;
  List<SelectedCategoryList> data;

  SelectCategoryModel({
    this.success,
    this.message,
    this.data,
  });

  SelectCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['sucess'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new SelectedCategoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class SelectedCategoryList {
  String name;
  String img;
  String id;

  SelectedCategoryList({
    this.name,
    this.img,
    this.id,
  });

  SelectedCategoryList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    img = json['url'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['img'] = this.img;
    data['id'] = this.id;
    return data;
  }
}
