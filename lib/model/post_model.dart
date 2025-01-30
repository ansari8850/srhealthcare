  import 'dart:convert';

import 'package:srhealthcare/model/login_user_model.dart';

class PostModel {
  int? id;
  dynamic userId;
  String? userName;
  String? fieldId;
  PostType? postType;
  String? fieldName;
  String? title;
  String? location;
  String? date;
  String? description;
  String? thumbnail;
  dynamic autoDeleteDate;
  String? status;
  int? isDisabled;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? postTypeId;
  UserModel? user;
  int? isSaved;
  String? rejectedReason;

  PostModel(
      {this.id,
      this.userId,
      this.userName,
      this.fieldId,
      this.postType,
      this.fieldName,
      this.title,
      this.location,
      this.date,
      this.description,
      this.thumbnail,
      this.autoDeleteDate,
      this.status,
      this.isDisabled,
      this.createdAt,
      this.updatedAt,
      this.postTypeId,
      this.user,
      this.isSaved,
      this.rejectedReason
      });

  factory PostModel.fromRawJson(String str) =>
      PostModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        userId: json["user_id"],
        userName: json["user_name"],
        fieldId: json["field_id"],
        postType: json["post_type"] == null
            ? null
            : PostType.fromJson(json["post_type"]),
        fieldName: json["field_name"],
        title: json["title"],
        location: json["location"],
        date: json["date"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        autoDeleteDate: json["auto_delete_date"],
        status: json["status"],
        isDisabled: json["is_disabled"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        postTypeId: json["post_type_id"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        isSaved: json["is_saved"],
        rejectedReason: json["rejected_reason"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_name": userName,
        "field_id": fieldId,
        "post_type": postType?.toJson(),
        "field_name": fieldName,
        "title": title,
        "location": location,
        "date": date,
        "description": description,
        "thumbnail": thumbnail,
        "auto_delete_date": autoDeleteDate,
        "status": status,
        "is_disabled": isDisabled,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "post_type_id": postTypeId,
        "user": user?.toJson(),
        "is_saved": isSaved,
        "rejected_reason" :rejectedReason
      };
}

class PostType {
  int? id;
  String? type;
  String? name;
  dynamic parentId;
  dynamic extraData;
  String? fieldId;
  String? location;
  dynamic subType;
  String? fieldName;
  int? isDisabled;
  DateTime? createdAt;
  DateTime? updatedAt;

  PostType({
    this.id,
    this.type,
    this.name,
    this.parentId,
    this.extraData,
    this.fieldId,
    this.location,
    this.subType,
    this.fieldName,
    this.isDisabled,
    this.createdAt,
    this.updatedAt,
  });

  factory PostType.fromRawJson(String str) =>
      PostType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostType.fromJson(Map<String, dynamic> json) => PostType(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        parentId: json["parent_id"],
        extraData: json["extra_data"],
        fieldId: json["field_id"],
        location: json["location"],
        subType: json["sub_type"],
        fieldName: json["field_name"],
        isDisabled: json["is_disabled"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "parent_id": parentId,
        "extra_data": extraData,
        "field_id": fieldId,
        "location": location,
        "sub_type": subType,
        "field_name": fieldName,
        "is_disabled": isDisabled,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}