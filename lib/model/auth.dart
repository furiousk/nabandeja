class Auth {
  String? login;
  String? password;
  bool? keepAlive;

  Auth({
    this.login,
    this.password,
    this.keepAlive,
  });

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        login: json["login"],
        password: json["password"],
        keepAlive: json["keepAlive"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "password": password,
        "keepAlive": keepAlive,
      };
}
