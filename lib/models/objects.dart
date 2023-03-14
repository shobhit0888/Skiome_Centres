// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Objects {
  String? objectId;
  String? categoryId;
  String? centreName;
  String? centreUID;
  String? longDescription;
  String? objectInfo;
  String? objectName;
  String? objectPrice;
  Timestamp? publishDate;
  String? status;
  String? thumbnailUrl;
  Objects({
    this.objectId,
    this.categoryId,
    this.centreName,
    this.centreUID,
    this.longDescription,
    this.objectInfo,
    this.objectName,
    this.objectPrice,
    this.publishDate,
    this.status,
    this.thumbnailUrl,
  });
  Objects.fromJson(Map<String, dynamic> json) {
    objectId = json["objectId"];
    categoryId = json["categoryId"];
    centreName = json["categoryName"];
    centreUID = json["centreUID"];
    longDescription = json["longDescription"];
    objectInfo = json["objectInfo"];
    objectName = json["objectName"];
    objectPrice = json["objectPrice"];
    publishDate = json["publishDate"];
    status = json["status"];
    thumbnailUrl = json["thumbnailUrl"];
  }
}
