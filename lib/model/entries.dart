import 'abstract_generic_model.dart';

class Entries extends AbstractGenericModel {
  String? entryId;
  int? accountPosition;
  bool? entryCanceled;
  int? entryOrderStatus;
  int? entryQuantity;
  int? entrySalesOrderStatus;
  bool? entryTransfer;
  String? itemDescription;
  String? note;

  @override
  Entries.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    entryId = json["entryId"];
    accountPosition = json["accountPosition"];
    entryCanceled = json["entryCanceled"];
    entryOrderStatus = json["entryOrderStatus"];
    entryQuantity = json["entryQuantity"];
    entrySalesOrderStatus = json["entrySalesOrderStatus"];
    entryTransfer = json["entryTransfer"];
    itemDescription = json["itemDescription"];
    note = json["note"];
  }

  @override
  Map<String, dynamic> toJson() => {
        "entryId": entryId,
        "accountPosition": accountPosition,
        "entryCanceled": entryCanceled,
        "entryOrderStatus": entryOrderStatus,
        "entryQuantity": entryQuantity,
        "entrySalesOrderStatus": entrySalesOrderStatus,
        "entryTransfer": entryTransfer,
        "itemDescription": itemDescription,
        "note": note,
      };
}
