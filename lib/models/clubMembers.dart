// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class ClubMembers {
  String? name;
  String? phoneNumber;
  String? email;
  String? memberPost;
  String? category;
  String? photoUrl;
  String? centreUID;
  String? schoolUID;
  String? clubUID;
  Timestamp? publishDate;
  String? categoryUID;
  String? clubMemberUID;
  ClubMembers({
    this.name,
    this.phoneNumber,
    this.email,
    this.memberPost,
    this.category,
    this.photoUrl,
    this.centreUID,
    this.schoolUID,
    this.clubUID,
    this.publishDate,
    this.categoryUID,
    this.clubMemberUID,
  });

  ClubMembers.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    category = json["category"];
    photoUrl = json["photoUrl"];
    centreUID = json["centreUID"];
    schoolUID = json["schoolUID"];
    clubUID = json["clubUID"];
    email = json["email"];
    phoneNumber = json["phoneNumber"];
    categoryUID = json["categoryUID"];
    clubMemberUID = json["clubMemberUID"];
    publishDate = json["publishDate"];
    memberPost = json["memberPost"];
  }
}
