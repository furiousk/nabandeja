import 'kds.dart';

class SocketMsg {
  int? kdsMessageType;
  List<Kds>? kdsList;

  SocketMsg({
    this.kdsMessageType,
    this.kdsList,
  });

  factory SocketMsg.fromJson(Map<String, dynamic> json) => SocketMsg(
        kdsMessageType: json["kdsMessageType"],
        kdsList: (json["kdsList"] as List).map((e) => Kds.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "kdsMessageType": kdsMessageType,
        "kdsList": kdsList,
      };
}
