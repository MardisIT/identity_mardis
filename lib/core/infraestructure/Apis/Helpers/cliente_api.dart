// ignore_for_file: constant_identifier_names

enum Service {
  Login,

}

class HTTP {
  static const String Login = "/Supervisor/LoginSupervisor";

  static String getSufix(Service service) {
    switch (service) {
      case Service.Login:
        return Login;
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
