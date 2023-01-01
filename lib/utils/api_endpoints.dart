class APIEndpoints {
  static const String _baseUrl = "https://api.ugurdindar.com/";

  // authentication endpoints
  static const String registerEndpoint = "${_baseUrl}auth/register";
  static const String loginEndpoint = "${_baseUrl}auth/login";

  // patient endpoints
  static const String getPatientsEndpoint = "${_baseUrl}patient/list";
  static const String getPatientById = "${_baseUrl}patient/get";
  static const String getLaboratoryResultsById =
      "${_baseUrl}patient/laboratory/get";
  static const String getBloodSugarTraceById =
      "${_baseUrl}patient/bloodsugar/get";
  static const String getMedicinesById = "${_baseUrl}patient/medicine/get";
  static const String getVitalSignById = "${_baseUrl}patient/vitalsign/get";
  static const String getPatientDiagnosisById =
      "${_baseUrl}patient/diagnosis/get";
  static const String getPatientFallRiskFactors =
      "${_baseUrl}patient/fallrisk/get";
  static const String getFallRiskFormFactors =
      "${_baseUrl}patient/fallrisk/factor/list";
  static const String getNortonPressureUlcerById =
      "${_baseUrl}patient/nortonpressureulcer/get";

  // scenario endpoint
  static const String getScenario = "${_baseUrl}scenario/get";

  // grade endpoints
  static const String createGrade = "${_baseUrl}grade/create";
  static const String getGrade = "${_baseUrl}grade/user";
}
