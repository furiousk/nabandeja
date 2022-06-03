import 'abstract_generic_model.dart';
import 'kds.dart';

class SocketMsg extends AbstractGenericModel {
  int? kdsMessageType;
  List<Kds>? kdsList;

  @override
  SocketMsg.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    var entriesList = json["kdsList"] as List;

    kdsMessageType = json["kdsMessageType"];
    kdsList = entriesList.map((e) => Kds.fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() => {
        "kdsMessageType": kdsMessageType,
        "kdsList": kdsList,
      };
}
