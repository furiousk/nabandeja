import 'entries.dart';

class Kds {
  String? id;
  String? status;
  List<Entries>? entries;

  Kds({
    this.id,
    this.status,
    this.entries,
  });

  factory Kds.fromJson(Map<String, dynamic> json) => Kds(
        id: json["id"],
        status: json["status"],
        entries:
            (json["entries"] as List).map((e) => Entries.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "entries": entries,
      };
}
