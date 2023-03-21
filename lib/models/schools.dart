// ignore_for_file: public_member_api_docs, sort_constructors_first
class Schools {
  String? schoolUID;
  String? schoolName;
  String? schoolEmail;
  String? photoUrl;
  String? status;
  String? centreUID;
  String? schoolAddress;
  String? cityCode;
  Schools({
    this.schoolUID,
    this.schoolName,
    this.schoolEmail,
    this.photoUrl,
    this.status,
    this.centreUID,
    this.schoolAddress,
    this.cityCode,
  });
  Schools.fromJson(Map<String, dynamic> json) {
    schoolUID = json["schoolUID"];
    schoolName = json["schoolName"];
    schoolEmail = json["schoolEmail"];
    photoUrl = json["photoUrl"];
    status = json["status"];
    centreUID = json["centreUID"];
    schoolAddress = json["schoolAddress"];
    cityCode = json["cityCode"];
  }
}
