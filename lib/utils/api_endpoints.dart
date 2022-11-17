class APIEndpoints {
  static const String _baseUrl = "http://server.ugurdindar.com:5000/";

  //example post
  static const String examplePostEndpoint =
      "${_baseUrl}api/exampleRoute/examplePost";

  //authentication
  static const String registerEndpoint = "${_baseUrl}auth/register";
  static const String loginEndpoint = "${_baseUrl}auth/login";

  //patient
  static const String getPatientsEndpoint = "${_baseUrl}patient/list";
}
