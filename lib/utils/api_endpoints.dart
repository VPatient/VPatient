class APIEndpoints {
  static const String _baseUrl = "https://api.ugurdindar.com/";

  //example post
  static const String examplePostEndpoint =
      "${_baseUrl}api/exampleRoute/examplePost";

  //authentication
  static const String registerEndpoint = "${_baseUrl}auth/register";
  static const String loginEndpoint = "${_baseUrl}auth/login";

  //patient
  static const String getPatientsEndpoint = "${_baseUrl}patient/list";
  static const String getPatientById = "${_baseUrl}patient/get";
  static const String getLaboratoryResultsById = "${_baseUrl}patient/laboratory/get";
  static const String getBloodSugarTraceById = "${_baseUrl}patient/bloodsugar/get";
  static const String getMedicinesById = "${_baseUrl}patient/medicine/get";
  static const String getVitalSignById = "${_baseUrl}patient/vitalsign/get";

  //scenario
  static const String getScenario = "${_baseUrl}scenario/get";
}
