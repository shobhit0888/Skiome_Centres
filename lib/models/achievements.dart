// ignore_for_file: public_member_api_docs, sort_constructors_first
class Achievements {
  String? photoUrl;
  String? competitionName;
  String? awardedBy;
  String? authorisedBy;
  String? centreUID;
  String? achievementUID;
  String? schoolUID;
  String? achievementName;
  Achievements({
    this.photoUrl,
    this.competitionName,
    this.awardedBy,
    this.authorisedBy,
    this.centreUID,
    this.achievementUID,
    this.schoolUID,
    this.achievementName,
  });
  Achievements.fromJson(Map<String, dynamic> json) {
    photoUrl = json["photoUrl"];
    competitionName = json["competitionName"];
    awardedBy = json["awardedBy"];
    authorisedBy = json["authorisedBy"];
    centreUID = json["centreUID"];
    achievementUID = json["achievementUID"];
    schoolUID = json["schoolUID"];
    achievementName = json["achievementName"];
  }
}
