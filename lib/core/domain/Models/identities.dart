import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Identity {
  String id;
  RxBool isChecked;
  RxDouble progressValue;
  int time;
  RxString code;

  String systemAplication;
  String email;

  String jsonPreference;

  Identity({
    required this.id,
    required this.time,
    required this.code,
    required this.systemAplication,
    required this.email,
    required this.jsonPreference,
    bool isChecked = false,
    double progressValue = 0.0,
    // required timeExpiration,
  })  : isChecked = isChecked.obs,
        progressValue = progressValue.obs;

  factory Identity.fromJson(Map<String, dynamic> json) => Identity(
        id: json["id"],
        time: json["time"],
        code: (json["code"].toString()).obs,
        systemAplication: json["systemAplication"],
        email: json["email"], 
        jsonPreference: json["jsonPreference"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
        "code": code,
        "systemAplication": systemAplication,
        "email": email,
      };
}
