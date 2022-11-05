class APIEndpoints {
  static const String _baseUrl = "http://server.ugurdindar.com:5000/";

  //example post
  static const String examplePostEndpoint =
      "${_baseUrl}api/exampleRoute/examplePost";

  //register
  static const String registerEndpoint = "${_baseUrl}auth/register";
  //login
  static const String loginEndpoint = "${_baseUrl}auth/login";
}
