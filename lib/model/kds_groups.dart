import 'abstract_generic_model.dart';

class KdsGroups extends AbstractGenericModel {
  String? id;
  String? displayId;
  String? displayDescription;

  @override
  KdsGroups.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json["id"];
    displayId = json["displayId"];
    displayDescription = json["displayDescription"];
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "displayId": displayId,
        "displayDescription": displayDescription,
      };
}
