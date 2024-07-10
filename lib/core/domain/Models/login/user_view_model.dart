import 'dart:convert';

class UserViewModel {
  UserViewModel({
    this.id,
    this.email,
    this.password,
    this.statusRegister,
    this.idProfile,
    this.key,
    this.dateKey,
    this.idUser,
    this.tenant,
    this.listTenant,
    this.idPersonCore,
    this.idAccountCore,
    this.campana,
  });

  String? id;
  String? email;
  String? password;
  String? statusRegister;
  String? idProfile;
  String? key;
  String? dateKey;
  String? idUser;
  String? tenant;
  List<ListTenant>? listTenant;
  String? idPersonCore;
  String? idAccountCore;
  String? campana;

  factory UserViewModel.fromRawJson(String str) =>
      UserViewModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserViewModel.fromJson(Map<String, dynamic> json) =>
      UserViewModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        statusRegister: json["statusRegister"],
        idProfile: json["idProfile"],
        key: json["key"],
        dateKey: json["dateKey"],
        idUser: json["idUser"],
        tenant: json["tenant"],
        idPersonCore: json["idPersonCore"],
        idAccountCore: json["idAccountCore"],
        campana: json["campana"],
        listTenant: List<ListTenant>.from(
            json["listTenant"].map((x) => ListTenant.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "statusRegister": statusRegister,
        "idProfile": idProfile,
        "key": key,
        "dateKey": dateKey,
        "idUser": idUser,
        "tenant": tenant,
        "idPersonCore": idPersonCore,
        "idAccountCore": idAccountCore,
        "campana": campana,
        "listTenant": List<dynamic>.from(listTenant!.map((x) => x.toMap())),
      };
}

class ListTenant {
  String name;
  String? alias;
  String? iduser;

  ListTenant({
    required this.name,
    this.alias,
    this.iduser,
  });

  factory ListTenant.fromJson(String str) =>
      ListTenant.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListTenant.fromMap(Map<String, dynamic> json) => ListTenant(
        name: json["name"],
        alias: json["alias"],
        iduser: json["iduser"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "alias": alias,
        "iduser": iduser,
      };
}
