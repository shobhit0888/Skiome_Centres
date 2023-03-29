// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Categories {
  String? categoryId;
  String? categoryInfo;
  String? categoryName;
  String? centreUID;
  // Timestamp? publishDate;
  String? publishDate;
  String? status;
  String? thumbnailUrl;
  Categories({
    this.categoryId,
    this.categoryInfo,
    this.categoryName,
    this.centreUID,
    this.publishDate,
    this.status,
    this.thumbnailUrl,
  });
  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json["categoryId"];
    categoryInfo = json["categoryInfo"];
    categoryName = json["categoryName"];
    centreUID = json["centreUID"];
    publishDate = json["publishDate"].toString();
    status = json["status"];
    thumbnailUrl = json["thumbnailUrl"];
  }
}
