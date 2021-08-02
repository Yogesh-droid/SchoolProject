class CreateNewsFeedFormResponse {
  bool success;
  Data data;
  Null message;

  CreateNewsFeedFormResponse({this.success, this.data, this.message});

  CreateNewsFeedFormResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<Roles> roles;
  List<Classes> classes;

  Data({this.roles, this.classes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['roles'] != null) {
      roles = new List<Roles>();
      json['roles'].forEach((v) {
        roles.add(new Roles.fromJson(v));
      });
    }
    if (json['classes'] != null) {
      classes = new List<Classes>();
      json['classes'].forEach((v) {
        classes.add(new Classes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.roles != null) {
      data['roles'] = this.roles.map((v) => v.toJson()).toList();
    }
    if (this.classes != null) {
      data['classes'] = this.classes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int id;
  String name;
  String type;
  int activeStatus;
  String createdBy;
  String updatedBy;
  String createdAt;
  String updatedAt;
  int schoolId;
  int isSaas;

  Roles(
      {this.id,
        this.name,
        this.type,
        this.activeStatus,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.schoolId,
        this.isSaas});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    activeStatus = json['active_status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    schoolId = json['school_id'];
    isSaas = json['is_saas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['active_status'] = this.activeStatus;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['school_id'] = this.schoolId;
    data['is_saas'] = this.isSaas;
    return data;
  }
}

class Classes {
  int id;
  String className;
  int activeStatus;
  String createdAt;
  String updatedAt;
  int createdBy;
  int updatedBy;
  int schoolId;
  int academicId;

  Classes(
      {this.id,
        this.className,
        this.activeStatus,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.schoolId,
        this.academicId});

  Classes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
    activeStatus = json['active_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    schoolId = json['school_id'];
    academicId = json['academic_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['class_name'] = this.className;
    data['active_status'] = this.activeStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['school_id'] = this.schoolId;
    data['academic_id'] = this.academicId;
    return data;
  }
}