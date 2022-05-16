
import 'dart:convert';

Project projectFromMap(String str) => Project.fromMap(json.decode(str));

String projectToMap(Project data) => json.encode(data.toMap());

class Project {
    Project({
        required this.success,
        required this.data,
        required this.message,
    });

    bool success;
    Data data;
    String message;

    factory Project.fromMap(Map<String, dynamic> json) => Project(
        success: json["success"],
        data: Data.fromMap(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "data": data.toMap(),
        "message": message,
    };
}

class Data {
    Data({
        required this.noRecords,
        required this.records,
        required this.totalRecords,
    });

    int noRecords;
    List<Record> records;
    int totalRecords;

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        noRecords: json["noRecords"],
        records: List<Record>.from(json["records"].map((x) => Record.fromMap(x))),
        totalRecords: json["totalRecords"],
    );

    Map<String, dynamic> toMap() => {
        "noRecords": noRecords,
        "records": List<dynamic>.from(records.map((x) => x.toMap())),
        "totalRecords": totalRecords,
    };
}

class Record {
    Record({
        required this.isActive,
        required this.updatedAt,
        required this.createdAt,
        required this.isDeleted,
        required this.projectName,
        required this.description,
        required this.id,
    });

    String isActive;
    int updatedAt;
    int createdAt;
    String isDeleted;
    String projectName;
    String description;
    String id;

    factory Record.fromMap(Map<String, dynamic> json) => Record(
        isActive: json["isActive"],
        updatedAt: json["updatedAt"],
        createdAt: json["createdAt"],
        isDeleted: json["isDeleted"],
        projectName: json["projectName"],
        description: json["description"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "isActive": isActive,
        "updatedAt": updatedAt,
        "createdAt": createdAt,
        "isDeleted": isDeleted,
        "projectName": projectName,
        "description": description,
        "id": id,
    };
}
