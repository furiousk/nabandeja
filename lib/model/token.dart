import 'abstract_generic_model.dart';

class Token extends AbstractGenericModel {
  String? id;
  bool? authenticated;
  String? created;
  String? expiration;
  String? newPasswordToken;

  @override
  Token.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json["id"];
    authenticated = json["authenticated"];
    created = json["created"];
    expiration = json["expiration"];
    newPasswordToken = json["newPasswordToken"];
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "authenticated": authenticated,
        "created": created,
        "expiration": expiration,
        "newPasswordToken": newPasswordToken,
      };
}
