import 'package:nabandeja/model/kds_order_status.dart';

class KdsOrder {
  String? id;
  String? accountId;
  bool? isSalesOrder;
  int? status;

  KdsOrder({
    this.id,
    this.accountId,
    this.isSalesOrder,
    this.status,
  });

  factory KdsOrder.fromJson(Map<String, dynamic> json) => KdsOrder(
    id: json["id"],
    accountId: json["accountId"],
    isSalesOrder: json["isSalesOrder"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "accountId": accountId,
    "isSalesOrder": isSalesOrder,
    "status": status,
  };
}
