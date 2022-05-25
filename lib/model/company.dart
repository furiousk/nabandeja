class Company {
  String? id;
  String? companyName;
  String? companyFantasyName;
  String? logo;
  int? companyType;
  int? companyStatus;

  Company({
    this.id,
    this.companyName,
    this.companyFantasyName,
    this.logo,
    this.companyType,
    this.companyStatus,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        companyName: json["companyName"],
        companyFantasyName: json["companyFantasyName"],
        logo: json["logo"],
        companyType: json["companyType"],
        companyStatus: json["companyStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "companyName": companyName,
        "companyFantasyName": companyFantasyName,
        "logo": logo,
        "companyType": companyType,
        "companyStatus": companyStatus,
      };
}
