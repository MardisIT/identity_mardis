import 'package:identity_engine/core/domain/Models/login/login_response.dart';
import 'package:identity_engine/core/infrastructure/Apis/Helpers/cliente_api.dart';
import 'dart:convert';

import 'package:identity_engine/core/infrastructure/Apis/Helpers/request.dart';

class LoginRequestGet {
  final RequestApiKey _callApi = RequestApiKey();

  Future<QRCodeResponse> getUser(String idUser, String tenant) async {
    var url = HTTP.getAddress(Service.QrRegenerate);

    try {
      Uri combinedUrl = Uri.parse(url + idUser);
      GetRequest service = await _callApi.getTennat(combinedUrl, tenant);
      if (service.complete && service.response.isNotEmpty) {
        var jsonResponse = json.decode(service.response);
        var result = QRCodeResponse.fromJson(jsonResponse);
        return result;
      }
      return QRCodeResponse(
        status: '',
        messege: '',
      );
    } catch (e) {
      return QRCodeResponse(
        status: '',
        messege: '',
      );
    }
  }

    Future<QRCodeResponse> unlockUser(String idUser, String device, String tenant) async {
    var url = HTTP.getAddress(Service.UnlockUser);

    try {
      // Uri combinedUrl = Uri.parse(url + idUser);
      Uri combinedUrl = Uri.parse('$url&IdUser=$idUser&device=$device');
      GetRequest service = await _callApi.getTennat(combinedUrl, tenant);
      if (service.complete && service.response.isNotEmpty) {
        var jsonResponse = json.decode(service.response);
        var result = QRCodeResponse.fromJson(jsonResponse);
        return result;
      }
      return QRCodeResponse(
        status: '',
        messege: '',
      );
    } catch (e) {
      return QRCodeResponse(
        status: '',
        messege: '',
      );
    }
  }
}
