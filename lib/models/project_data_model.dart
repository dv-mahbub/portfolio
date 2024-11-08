
import 'dart:convert';

ProjectDataModel projectDataModelFromJson(String str) => ProjectDataModel.fromJson(json.decode(str));

String projectDataModelToJson(ProjectDataModel data) => json.encode(data.toJson());

class ProjectDataModel {
    List<Project>? projects;
    List<Project>? packages;

    ProjectDataModel({
        this.projects,
        this.packages,
    });

    factory ProjectDataModel.fromJson(Map<String, dynamic> json) => ProjectDataModel(
        projects: json["projects"] == null ? [] : List<Project>.from(json["projects"]!.map((x) => Project.fromJson(x))),
        packages: json["packages"] == null ? [] : List<Project>.from(json["packages"]!.map((x) => Project.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "projects": projects == null ? [] : List<dynamic>.from(projects!.map((x) => x.toJson())),
        "packages": packages == null ? [] : List<dynamic>.from(packages!.map((x) => x.toJson())),
    };
}

class Project{
    String? title;
    String? image;
    String? shortDescription;
    String? features;
    String? tools;
    String? url;

    Project({
        this.title,
        this.image,
        this.shortDescription,
        this.features,
        this.tools,
        this.url,
    });

    factory Project.fromJson(Map<String, dynamic> json) => Project(
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
