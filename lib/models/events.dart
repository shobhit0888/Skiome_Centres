// ignore_for_file: public_member_api_docs, sort_constructors_first
class Events {
  String? eventName;
  String? time;
  String? venue;
  String? openFor;
  String? organiser;
  String? description;
  String? registration;
  String? email;
  String? phoneNumber;
  String? eventUID;
  String? photoUrl;
  Events({
    this.eventName,
    this.time,
    this.venue,
    this.openFor,
    this.organiser,
    this.description,
    this.registration,
    this.email,
    this.phoneNumber,
    this.eventUID,
    this.photoUrl,
  });
  Events.fromJson(Map<String, dynamic> json) {
    eventName = json["eventName"];
    time = json["time"];
    eventUID = json["eventUID"];
    venue = json["venue"];
    openFor = json["openFor"];
    organiser = json["organiser"];
    description = json["description"];
    registration = json["registration"];
    email = json["email"];
    phoneNumber = json["phoneNumber"];
    photoUrl = json["photoUrl"];
  }
}
