import 'package:identity_engine/core/domain/Models/login/login_request.dart';
import 'package:identity_engine/core/domain/Models/login/login_response.dart';
import 'package:identity_engine/core/infrastructure/Apis/Helpers/cliente_api.dart';
import 'dart:convert';

import 'package:identity_engine/core/infrastructure/Apis/Helpers/request.dart';

class LoginRequestPost {
  final RequestApiKey _callApi = RequestApiKey();

  Future<QRCodeResponse> callAuthenticate(
      LoginRequestModel loginRequest, String tenant) async {
    var url = HTTP.getAddress(Service.QrLogin);

    try {
      Uri combinedUrl = Uri.parse(url);
      GetRequest service = await _callApi.postTenant(combinedUrl, tenant,
          body: loginRequest.toMap());
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
