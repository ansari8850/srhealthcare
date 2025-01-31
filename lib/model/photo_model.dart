import 'dart:convert';

class PhotoModel {
  String? name;
  String? url;

  PhotoModel({
    this.name,
    this.url,
  });

  PhotoModel copyWith({
    String? name,
    String? url,
  }) =>
      PhotoModel(
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory PhotoModel.fromRawJson(String str) =>
      PhotoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}