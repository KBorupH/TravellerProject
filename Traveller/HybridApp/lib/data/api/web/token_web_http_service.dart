import 'dart:convert';

import 'package:flutter_session_manager/flutter_session_manager.dart';

import 'package:http/http.dart';
import '../../models/login.dart';

class TokenWebHttpService {
  TokenWebHttpService(Client httpClient, String baseUrl) {
    _httpClient = httpClient;
    _baseUrl = baseUrl;
  }

  late final Client _httpClient;
  final String _storageTokenKey = "tokenKey";
  late final String _baseUrl;

  Future<String> getLocalAccessToken() async {
    return await _readTokenSecureStorage();
  }

  Future<bool> getRemoteAccessToken(Login login, bool register) async {
    String authEndpoint = "login";
    if (register) authEndpoint = "register";

    Uri requestUri = Uri.parse("$_baseUrl/authenticate/$authEndpoint");
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
    };

    var response = await _httpClient.post(
        requestUri,
        headers: requestHeader,
        body: json.encode(login.toJson()),
        encoding: Encoding.getByName("UTF-8"));

    if (response.statusCode == 200) {
      String token = json.decode(utf8.decode(response.bodyBytes))['access_token'];

      _writeTokenSecureStorage(token);

      return true;
    } else if (response.statusCode == 401) {
      return false;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          '[ERROR] Failed to get Token - response code: ${response.statusCode}');
    }
  }

  Future<void> _writeTokenSecureStorage(String token) async {
    await SessionManager().set(_storageTokenKey, token);
  }

  Future<String> _readTokenSecureStorage() async {
    if (await SessionManager().containsKey(_storageTokenKey))
      return await SessionManager().get(_storageTokenKey);
    return "";
  }

  Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
