import 'dart:convert';
import 'dart:io';
import 'package:identity_engine/core/Routes/router.dart';
import 'package:identity_engine/core/infrastructure/Apis/Utils/auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:identity_engine/core/infrastructure/Apis/Utils/http_errors.dart';
import 'package:identity_engine/core/infrastructure/Providers/local_provider.dart';

enum RequestType { post, put, get, delete }

LocalProvider _localRepositoryImpl = LocalProvider();

class Request {
  Future<String> getHeader() async {
    var token = await _localRepositoryImpl.getToken();
    return "Bearer $token";
  }

  Future<GetRequest> post(Uri url, {dynamic body}) async {
    return http
        .post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: await getHeader(),
        'Content-Type': 'application/json',
        'Tenant': 'EngineV2'
      },
      body: jsonEncode(body),
    )
        .then(
      (http.Response response) {
        final int statusCode = response.statusCode;

        return GetRequest(
            url.path, response.body, statusCode, RequestType.post);
      },
    );
  }

  Future<GetRequest> put(Uri url, {dynamic body}) async {
    return http
        .put(
      url,
      headers: {
        HttpHeaders.authorizationHeader: await getHeader(),
        'Content-Type': 'application/json',
        'Tenant': 'EngineV2'
      },
      body: json.encode(body),
    )
        .then(
      (http.Response response) {
        final int statusCode = response.statusCode;
        return GetRequest(url.path, utf8.decode(response.bodyBytes), statusCode,
            RequestType.put);
      },
    );
  }

  Future<GetRequest> get(Uri url) async {
    return http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: await getHeader(),
        'Content-Type': 'application/json',
        'Tenant': 'EngineV2'
      },
    ).then(
      (http.Response response) {
        final int statusCode = response.statusCode;
        return GetRequest(url.path, utf8.decode(response.bodyBytes), statusCode,
            RequestType.get);
      },
    );
  }

  Future<GetRequest> delete(Uri url) async {
    return http.delete(url, headers: {
      HttpHeaders.authorizationHeader: await getHeader(),
      'Content-Type': 'application/json',
      'Tenant': 'EngineV2'
    }).then(
      (http.Response response) {
        final int statusCode = response.statusCode;
        return GetRequest(url.path, utf8.decode(response.bodyBytes), statusCode,
            RequestType.delete);
      },
    );
  }
}

class RequestApiKey {
  Future<String> getHeader() async {
    var token = await _localRepositoryImpl.getToken();
    return "Bearer $token";
  }

  Future<GetRequest> post(Uri url, {dynamic body}) async {
    return http
        .post(
      url,
      headers: {
        "Chariot-APIKey": AuthorizationKey.chariotApiKey,
        'Content-Type': 'application/json',
        'Tenant': 'EngineV2'
      },
      body: jsonEncode(body),
    )
        .then(
      (http.Response response) {
        final int statusCode = response.statusCode;

        return GetRequest(
            url.path, response.body, statusCode, RequestType.post);
      },
    );
  }

  Future<GetRequest> put(Uri url, {dynamic body}) async {
    return http
        .put(
      url,
      headers: {
        "Chariot-APIKey": AuthorizationKey.chariotApiKey,
        'Content-Type': 'application/json',
        'Tenant': 'EngineV2'
      },
      body: json.encode(body),
    )
        .then(
      (http.Response response) {
        final int statusCode = response.statusCode;
        return GetRequest(url.path, utf8.decode(response.bodyBytes), statusCode,
            RequestType.put);
      },
    );
  }

  Future<GetRequest> getTennat(Uri url, String tenant) async {
    return http.get(
      url,
      headers: {
        "Chariot-APIKey": AuthorizationKey.chariotApiKey,
        'Content-Type': 'application/json',
        'Tenant': tenant
      },
    ).then(
      (http.Response response) {
        final int statusCode = response.statusCode;
        return GetRequest(url.path, utf8.decode(response.bodyBytes), statusCode,
            RequestType.get);
      },
    );
  }
//* ----------------------------------------------------------------------------- */

    Future<GetRequest> postTenant(Uri url, String tenant, {dynamic body} ) async {
    return http
        .post(
      url,
      headers: {
        "Chariot-APIKey": AuthorizationKey.chariotApiKey,
        'Content-Type': 'application/json',
        'Tenant': tenant
      },
      body: jsonEncode(body),
    )
        .then(
      (http.Response response) {
        final int statusCode = response.statusCode;

        return GetRequest(
            url.path, response.body, statusCode, RequestType.post);
      },
    );
  }

  //* ----------------------------------------------------------------------------- */

  Future<GetRequest> get(Uri url) async {
    return http.get(
      url,
      headers: {
        "Chariot-APIKey": AuthorizationKey.chariotApiKey,
        'Content-Type': 'application/json',
        'Tenant': 'EngineV2'
      },
    ).then(
      (http.Response response) {
        final int statusCode = response.statusCode;
        return GetRequest(url.path, utf8.decode(response.bodyBytes), statusCode,
            RequestType.get);
      },
    );
  }

  Future<GetRequest> delete(Uri url) async {
    return http.delete(url, headers: {
      "Chariot-APIKey": AuthorizationKey.chariotApiKey,
      'Content-Type': 'application/json',
      'Tenant': 'EngineV2'
    }).then(
      (http.Response response) {
        final int statusCode = response.statusCode;
        return GetRequest(url.path, utf8.decode(response.bodyBytes), statusCode,
            RequestType.delete);
      },
    );
  }
}

class GetRequest {
  bool complete = false;
  String response = "";
  int status = 0;

  GetRequest.empty() {
    response;
    status = 0;
    complete = false;
  }

  // ignore: no_leading_underscores_for_local_identifiers
  GetRequest(String url, String _response, int _status, RequestType type) {
    response = _response;
    status = _status;

    /* Token Invalid */
    if (status == HttpErrors.tokenExpired || status == HttpErrors.forbidden) {
      //TO CONSTANTS
      _localRepositoryImpl.clearAllData();
      Get.offAllNamed(Routes.splash);
      return;
    }

    if (status == HttpErrors.badRequest) {
      //TO CONSTANTS
      // ignore: avoid_print
      print("Error BAD REQUEST  url:$url , statusCode:$status, type:$type");
      complete = false;
      return;
    }

    /* reconnection error */
    if (status == HttpErrors.sideNotFoundWhere) {
      // ignore: avoid_print
      print(
          "Error Undefined url: fetching data url:$url , statusCode:$status, type:$type");
      complete = false;
      return;
    }

    /* Connection error */
    if (status < 200 || status > 400) {
      // ignore: avoid_print
      print(
          "Error loading: fetching data url:$url , statusCode:$status, type:$type");
      complete = false;
      return;
    }

    complete = true;
    return;
  }
}
