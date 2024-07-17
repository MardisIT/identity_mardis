import 'package:identity_engine/core/domain/Models/login/user_view_model.dart';

class QRCodeResponse {
  String status;
  String messege;
  dynamic error;
  QRCodeData? data;

  QRCodeResponse({
    required this.status,
    required this.messege,
    this.error,
    this.data,
  });

  factory QRCodeResponse.fromJson(Map<String, dynamic> json) => QRCodeResponse(
        status: json["status"],
        messege: json["messege"],
        error: json["error"],
        data:json["data"]==null?null: QRCodeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "messege": messege,
        "error": error,
        "data": data!.toJson(),
      };
}