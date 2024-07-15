import 'package:identity_engine/core/domain/Models/login/login_request.dart';
import 'package:identity_engine/core/domain/Models/login/login_response.dart';

abstract class ILoginProvider {
  Future<QRCodeResponse> authenticatior({ required LoginRequestModel loginRequest, required String tenant});
  Future<QRCodeResponse> getUserFromQR({ required String idUser, required String tenant});
}
