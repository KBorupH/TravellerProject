import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:traveller_app/data/api/http_client_service.dart';

class HttpTokenService{
  HttpTokenService(HttpClientService httpService, String baseUrl){
    _httpService = httpService;
    _baseUrl = baseUrl;
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  late final _storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  final String _storageTokenKey = "tokenKey";

  late final HttpClientService _httpService;
  late final String _baseUrl;


  Future<String> getAccessToken() async {
    String token = await _readTokenSecureStorage();

    if (token == ""){
      token = await _getAccessTokenServer();
    }

    return token;
  }

  Future<String> _getAccessTokenServer() async {
    final login = <String, dynamic>{};
    login.addAll({"username": "TestName"});
    login.addAll({"password": "TestPass"});

    var request = await _httpService.httpClient.postUrl(Uri.parse("$_baseUrl/Authentication/Login"));
    request.headers.add(HttpHeaders.contentTypeHeader, 'application/json');
    request.add(utf8.encode(json.encode(login)));

    var response = await request.close();
    if (response.statusCode == 200) {
      String responseBody = await response.transform(utf8.decoder).join();
      String token = json.decode(responseBody)['fullToken'];

      _writeTokenSecureStorage(token);

      return token;
    }else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          '[ERROR] Failed to get Token - response code: ${response.statusCode}');
    }
  }

  Future<void> _writeTokenSecureStorage(String token) async {
    await _storage.write(key: _storageTokenKey, value: token);
  }

  Future<String> _readTokenSecureStorage() async {
    return await _storage.read(key: _storageTokenKey) ?? "";
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