import 'abstract_generic_model.dart';
import 'entries.dart';

class Kds extends AbstractGenericModel {
  String? id;
  int? status;
  List<Entries>? entries;

  @override
  Kds.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    var entriesList = json["entries"] as List;

    id = json["id"];
    status = json["status"];
    entries = entriesList.map((e) => Entries.fromJson(e)).toList();
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "entries": entries,
      };
}
