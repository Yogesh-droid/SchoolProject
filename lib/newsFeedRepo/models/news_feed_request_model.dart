class CreateFeedRequestModel {
  String title;
  String description;
  String category;
  List<String> tag;
  List<int> className;
  String image;
  String imageLink;
  int roleId;
  String createdBy;
  int activeStatus;
  int isPublished;

  CreateFeedRequestModel(
      {this.title,
        this.description,
        this.category,
        this.tag,
        this.className,
        this.image,
        this.imageLink,
        this.roleId,
        this.createdBy,
        this.activeStatus,
        this.isPublished});

  CreateFeedRequestModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    category = json['category'];
    tag = json['tag'].cast<String>();
    className = json['class_name'].cast<int>();
    image = json['image'];
    imageLink = json['image_link'];
    roleId = json['role_id'];
    createdBy = json['created_by'];
    activeStatus = json['active_status'];
    isPublished = json['is_published'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['category'] = this.category;
    data['tag'] = this.tag;
    data['class_name'] = this.className;
    data['image'] = this.image;
    data['image_link'] = this.imageLink;
    data['role_id'] = this.roleId;
    data['created_by'] = this.createdBy;
    data['active_status'] = this.activeStatus;
    data['is_published'] = this.isPublished;
    return data;
  }
}