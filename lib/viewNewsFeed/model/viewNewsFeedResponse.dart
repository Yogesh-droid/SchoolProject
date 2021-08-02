class ViewNewsFeedResponse {
  bool success;
  List<Data> data;
  String message;

  ViewNewsFeedResponse({this.success, this.data, this.message});

  ViewNewsFeedResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int id;
  String title;
  String slug;
  String description;
  String category;
  String tag;
  String className;
  String image;
  String imageLink;
  int like;
  String comment;
  String share;
  int roleId;
  String createdBy;
  String updatedBy;
  int activeStatus;
  int isPublished;
  int isDeleted;
  String createdAt;
  String updatedAt;
  List<String> tags;
  List<String> classNames;
  List<int> permission;
  List<int> roles;
  List<Likes> likes;

  Data(
      {this.id,
        this.title,
        this.slug,
        this.description,
        this.category,
        this.tag,
        this.className,
        this.image,
        this.imageLink,
        this.like,
        this.comment,
        this.share,
        this.roleId,
        this.createdBy,
        this.updatedBy,
        this.activeStatus,
        this.isPublished,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.tags,
        this.classNames,
        this.permission,
        this.roles,
        this.likes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    category = json['category'];
    tag = json['tag'];
    className = json['class_name'];
    image = json['image'];
    imageLink = json['image_link'];
    like = json['like'];
    comment = json['comment'];
    share = json['share'];
    roleId = json['role_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    activeStatus = json['active_status'];
    isPublished = json['is_published'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tags = json['tags'].cast<String>();
    classNames = json['class_names'].cast<String>();
    permission = json['permission'].cast<int>();
    roles = json['roles'].cast<int>();
    if (json['likes'] != null) {
      likes = new List<Likes>();
      json['likes'].forEach((v) {
        likes.add(new Likes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['category'] = this.category;
    data['tag'] = this.tag;
    data['class_name'] = this.className;
    data['image'] = this.image;
    data['image_link'] = this.imageLink;
    data['like'] = this.like;
    data['comment'] = this.comment;
    data['share'] = this.share;
    data['role_id'] = this.roleId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['active_status'] = this.activeStatus;
    data['is_published'] = this.isPublished;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['tags'] = this.tags;
    data['class_names'] = this.classNames;
    data['permission'] = this.permission;
    data['roles'] = this.roles;
    if (this.likes != null) {
      data['likes'] = this.likes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Likes {
  int id;
  int userId;
  int forumId;
  String createdAt;
  String updatedAt;

  Likes({this.id, this.userId, this.forumId, this.createdAt, this.updatedAt});

  Likes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    forumId = json['forum_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['forum_id'] = this.forumId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}