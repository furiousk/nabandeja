import 'abstract_generic_model.dart';
import 'entries.dart';

class KdsSalesOrder extends AbstractGenericModel {
  String? accountId;
  String? accountName;
  String? deliveryPlaceName;
  String? displayDescription;
  String? displayId;
  bool? kdsOrderCanceled;
  int? kdsOrderStatus;
  String? kdsSalesOrderId;
  String? launchCode;
  String? mainAccountId;
  String? namePos;
  String? queueEndDate;
  String? salesOrderDate;
  String? timeTrackingDanger;
  String? timeTrackingNormal;
  String? timeTrackingWarning;
  List<Entries>? entries;

  @override
  KdsSalesOrder.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    var entriesList = json["entries"] as List;

    accountId = json["accountId"];
    accountName = json["accountName"];
    deliveryPlaceName = json["deliveryPlaceName"];
    displayDescription = json["displayDescription"];
    displayId = json["displayId"];
    kdsOrderCanceled = json["kdsOrderCanceled"];
    kdsOrderStatus = json["kdsOrderStatus"];
    kdsSalesOrderId = json["kdsSalesOrderId"];
    launchCode = json["launchCode"];
    mainAccountId = json["mainAccountId"];
    namePos = json["namePos"];
    queueEndDate = json["queueEndDate"];
    salesOrderDate = json["salesOrderDate"];
    timeTrackingDanger = json["timeTrackingDanger"];
    timeTrackingNormal = json["timeTrackingNormal"];
    timeTrackingWarning = json["timeTrackingWarning"];
    entries = entriesList.map((e) => Entries.fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "accountName": accountName,
        "deliveryPlaceName": deliveryPlaceName,
        "displayDescription": displayDescription,
        "displayId": displayId,
        "kdsOrderCanceled": kdsOrderCanceled,
        "kdsOrderStatus": kdsOrderStatus,
        "kdsSalesOrderId": kdsSalesOrderId,
        "launchCode": launchCode,
        "mainAccountId": mainAccountId,
        "namePos": namePos,
        "queueEndDate": queueEndDate,
        "salesOrderDate": salesOrderDate,
        "timeTrackingDanger": timeTrackingDanger,
        "timeTrackingNormal": timeTrackingNormal,
        "timeTrackingWarning": timeTrackingWarning,
        "entries": entries,
      };
}
