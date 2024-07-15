// ignore_for_file: constant_identifier_names

enum Service {
  Login,
  QrLogin,
  QrRegenerate,
}

class HTTP {
  static const String Login = "/Supervisor/LoginSupervisor";
  static const String QrLogin = "/login/ScanLoginQR";
  static const String QrRegenerate = "/login/UpdateSecurityCode?IdUser=C34FDD0F-8E18-4167-B869-F73C463188E7";


  static String getSufix(Service service) {
    switch (service) {
      case Service.Login:
        return Login;
      case Service.QrLogin:
        return QrLogin;
      case Service.QrRegenerate:
        return QrRegenerate;
      default:
        return "";
    }
  }

  static String getAddress(Service service) {
    //String baseURL = "https://enginecore-backend.azurewebsites.net/api";
    //String baseURL = "http://mardisservice.azurewebsites.net/api";
    //String baseURL= "https://surticompras.azurewebsites.net";
    String baseURL = "https://enginecoretest-backend.azurewebsites.net/api";
    //String baseURL = "https://localhost:7169/api";
    //String baseURL = "https://enginecore-backend.azurewebsites.net/api";
    return "$baseURL${getSufix(service)}";
  }
}
