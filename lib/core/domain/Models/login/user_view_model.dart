import 'package:get/get.dart';

class QRCodeData {
  String idUser;
  String loginCode;
  String phoneIdentifier;
  String codeExpiration;
  int timeExpiration;

  QRCodeData({
    required this.idUser,
    required this.loginCode,
    required this.phoneIdentifier,
    required this.codeExpiration,
    required this.timeExpiration,
  });

  factory QRCodeData.fromJson(Map<String, dynamic> json) => QRCodeData(
        idUser: json["idUser"],
        loginCode: json["loginCode"],
        phoneIdentifier: json["phoneIdentifier"],
        codeExpiration: json["codeExpiration"],
        timeExpiration: json["timeExpiration"],
      );

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "loginCode": loginCode,
        "phoneIdentifier": phoneIdentifier,
        "codeExpiration": codeExpiration,
        "timeExpiration": timeExpiration,
      };
}
