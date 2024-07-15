import 'dart:convert';

class LoginRequestModel {
  String idUser;
  String phoneIdentifier;

  LoginRequestModel({
    required this.idUser,
    required this.phoneIdentifier,
  });

  factory LoginRequestModel.fromJson(String str) =>
      LoginRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginRequestModel.fromMap(Map<String, dynamic> json) => LoginRequestModel(
        idUser: json["IdUser"],
        phoneIdentifier: json["PhoneIdentifier"],
      );

  Map<String, dynamic> toMap() => {
        "IdUser": idUser,
        "PhoneIdentifier": phoneIdentifier,
      };
}
