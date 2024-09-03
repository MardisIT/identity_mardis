import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Identity {
  String id;
  RxBool isChecked;
  RxDouble progressValue;
  int time;
  RxString? code;
  String? codestaitc;
  String systemAplication;
  String email;
  String tenant;
  String jsonPreference;
  String? device;

  Identity({
    required this.id,
    required this.time,
    required this.systemAplication,
    required this.email,
    required this.jsonPreference,
    required this.tenant,
    this.codestaitc,
    this.device,
    bool isChecked = false,
    double progressValue = 0.0,
    String code = '',
    // required timeExpiration,
  })  : isChecked = isChecked.obs,
        progressValue = progressValue.obs,
        code = code.obs;

  factory Identity.fromJson(Map<String, dynamic> json) => Identity(
        id: json["id"],
        time: json["time"],
        code: (json["code"].toString()),
        // code: json["code"].toString(),
        systemAplication: json["systemAplication"],
        email: json["email"],
        jsonPreference: json["jsonPreference"] ?? '',
        codestaitc: json["codestaitc"],
        tenant: json["tenant"],
        device: json["device"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
        // "code": code,
        "codestaitc": codestaitc,
        "systemAplication": systemAplication,
        "email": email,
        "device": device,
      };
}
