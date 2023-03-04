// To parse this JSON data, do
//
//     final bucketRequestModel = bucketRequestModelFromJson(jsonString);

import 'dart:convert';

BucketRequestModel bucketRequestModelFromJson(String str) =>
    BucketRequestModel.fromJson(json.decode(str));

String bucketRequestModelToJson(BucketRequestModel data) =>
    json.encode(data.toJson());

class BucketRequestModel {
  BucketRequestModel({
    required this.task,
    required this.dateTime,
  });

  String task;
  String dateTime;

  factory BucketRequestModel.fromJson(Map<String, dynamic> json) =>
      BucketRequestModel(
        task: json["task"],
        dateTime: json["dateTime"],
      );

  Map<String, dynamic> toJson() => {
        "task": task,
        "dateTime": dateTime,
      };
}
