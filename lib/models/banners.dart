// ignore_for_file: public_member_api_docs, sort_constructors_first
class Banners {
  String? photoUrl;
  String? title;
  Banners({
    this.photoUrl,
    this.title,
  });
  Banners.fromJson(Map<String, dynamic> json) {
    photoUrl = json["photoUrl"];
    title = json["title"];
  }
}
