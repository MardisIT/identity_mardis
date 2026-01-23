// ignore_for_file: constant_identifier_names

enum Service {
  Login,
  QrLogin,
  QrRegenerate,
  UnlockUser,
}

class HTTP {
  static const String Login = "/Supervisor/LoginSupervisor";
  static const String QrLogin = "/login/ScanLoginQR";
  static const String QrRegenerate = "/login/UpdateSecurityCode?IdUser=";
  static const String UnlockUser = "/login/unLockUserSecurityCode?";

  static String getSufix(Service service) {
    switch (service) {
      case Service.Login:
        return Login;
      case Service.QrLogin:
        return QrLogin;
      case Service.QrRegenerate:
        return QrRegenerate;
      case Service.UnlockUser:
        return UnlockUser;
      default:
        return "";
    }
  }

  static String getAddress(Service service) {
    // String baseURL = "https://enginecoretest-backend.azurewebsites.net/api";
    // String baseURL = "https://enginecore-backend.azurewebsites.net/api";
    // String baseURL = "https://enginecore-backend-test.azurewebsites.net/api";
    String baseURL = "https://enginecorev2-backend.azurewebsites.net/";
    return "$baseURL${getSufix(service)}";
  }
}
