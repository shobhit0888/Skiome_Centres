// ignore_for_file: public_member_api_docs, sort_constructors_first
class Orders {
  String? addressId;
  bool? isSuccess;
  String? orderBy;
  String? orderTime;
  String? paymentDetail;
  List<String>? productIds;
  String? status;
  String? centreUID;
  String? categoryId;
  double? totalAmount;
  Orders({
    this.addressId,
    this.isSuccess,
    this.orderBy,
    this.orderTime,
    this.paymentDetail,
    this.productIds,
    this.status,
    this.centreUID,
    this.categoryId,
    this.totalAmount,
  });
  Orders.fromJson(Map<String, dynamic> json) {
    addressId = json["addressId"];
    isSuccess = json["isSuccess"];
    orderBy = json["orderBy"];
    orderTime = json["orderTime"];
    paymentDetail = json["paymentDetail"];
    productIds = List<String>.from(json["productIds"]);
    // productIds = json["productIds"];
    status = json["status"];
    centreUID = json["centreUID"];
    categoryId = json["categoryId"];
    totalAmount = json["totalAmount"];
  }
}
