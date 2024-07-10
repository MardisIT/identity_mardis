import 'dart:convert';

class User {
  String id;
  String email;
  String name;
  String idtype;
  String idAccount;
  String init;
  String rolename;
  String tenant;
  User({
    this.id = "",
    this.email = "",
    this.name = "",
    this.idtype = "",
    this.idAccount = "",
    this.init = "",
    this.rolename = "",
    this.tenant = "",
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.empty() => User(
        email: "",
        idAccount: "",
        id: "",
        init: "",
        idtype: "",
        name: "",
        rolename: "",
        tenant: "",
      );

  factory User.fromJson(Map json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        idtype: json["idType"],
        idAccount: json["idAccount"],
        rolename: json["roleName"],
        init: json["init"] ?? "",
        tenant: json["tenant"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "idtype": idtype,
        "idAccount": idAccount,
        "init": init,
        "rolename": rolename,
        "tenant": tenant,
      };
}
