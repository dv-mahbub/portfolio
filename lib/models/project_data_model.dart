import 'dart:convert';

ProjectDataModel projectDataModelFromJson(String str) =>
    ProjectDataModel.fromJson(json.decode(str));

String projectDataModelToJson(ProjectDataModel data) =>
    json.encode(data.toJson());

class ProjectDataModel {
  List<ProjectData>? data;

  ProjectDataModel({
    this.data,
  });

  factory ProjectDataModel.fromJson(Map<String, dynamic> json) =>
      ProjectDataModel(
        data: json["data"] == null
            ? []
            : List<ProjectData>.from(
                json["data"]!.map((x) => ProjectData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProjectData {
  String? title;
  String? image;
  String? shortDescription;
  String? features;
  String? tools;
  String? url;

  ProjectData({
    this.title,
    this.image,
    this.shortDescription,
    this.features,
    this.tools,
    this.url,
  });

  factory ProjectData.fromJson(Map<String, dynamic> json) => ProjectData(
        title: json["title"],
        image: json["image"],
        shortDescription: json["shortDescription"],
        features: json["features"],
        tools: json["tools"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "shortDescription": shortDescription,
        "features": features,
        "tools": tools,
        "url": url,
      };
}
