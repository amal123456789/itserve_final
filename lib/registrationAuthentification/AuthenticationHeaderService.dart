import 'package:itservpfeapp/registrationAuthentification/SessionStorageService.dart';
import 'package:flutter/cupertino.dart';
class AuthenticationHeaderService {
  static Future<Map<String, String>> createAuthHeader() async {
    var sessionStorageService = await SessionStorageService.getInstance();
    var accessToken = sessionStorageService.retriveAccessToken();
    if (accessToken == null) {
      debugPrint("No access token in local storage found. Please log in.");
      return null;
    }
    return {"Authorization": "Bearer $accessToken", "Content-Type": "application/json"};
  }
}
