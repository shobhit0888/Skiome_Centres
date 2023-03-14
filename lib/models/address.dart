// ignore_for_file: public_member_api_docs, sort_constructors_first
class Address {
  String? name;
  String? phoneNumber;
  String? street;
  String? address1;
  String? city;
  String? stateCountry;
  String? completeAddress;
  Address({
    this.name,
    this.phoneNumber,
    this.street,
    this.address1,
    this.city,
    this.stateCountry,
    this.completeAddress,
  });
  Address.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    phoneNumber = json["phoneNumber"];
    street = json["street"];
    address1 = json["address1"];
    city = json["city"];
    stateCountry = json["stateCountry"];
    completeAddress = json["completeAddress"];
  }
}
