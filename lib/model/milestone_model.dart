// To parse this JSON data, do
//
//     final milestoneModel = milestoneModelFromJson(jsonString);

import 'dart:convert';

List<MilestoneModel> get milestonlist => List<MilestoneModel>.from(
      _milestone.map(
        (x) => MilestoneModel.fromJson(x),
      ),
    );

String milestoneModelToJson(List<MilestoneModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MilestoneModel {
  MilestoneModel({
    required this.header,
    required this.subHeader,
    this.isCompleted = false,
    this.pageIndex = 0,
  });

  String header;
  String subHeader;
  bool isCompleted;
  int pageIndex;

  factory MilestoneModel.fromJson(Map<String, dynamic> json) => MilestoneModel(
        header: json["header"] ?? "",
        subHeader: json["sub_header"] ?? "",
        isCompleted: json["is_completed"] ?? false,
        pageIndex: json["page_index"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "header": header,
        "sub_header": subHeader,
        "is_completed": isCompleted,
      };
}

List<Map<String, dynamic>> _milestone = [
  {
    "header": "1",
    "sub_header": "Select\nYour Role",
    "is_completed": false,
    "page_index": 0,
  },
  {
    "header": "2",
    "sub_header": "Personal\nInformation",
    "is_completed": false,
    "page_index": 1,
  },
  {
    "header": "3",
    "sub_header": "Personal\nInformation",
    "is_completed": false,
    "page_index": 2,
  },
];
