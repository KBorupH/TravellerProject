import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class HttpClientService {
  late final HttpClient _httpClient;
  HttpClient get httpClient => _httpClient;

  Future<HttpClientService> init() async {
    await _initializeHttpClient();
    return this;
  }

  Future<void> _initializeHttpClient() async {
    try {
      // ByteData dataP12 = await rootBundle.load('assets/certificates/localhost+2-client.p12');
      // List<int> serverP12 = dataP12.buffer.asUint8List();
      //
      // ByteData dataPem = await rootBundle.load('assets/certificates/localhost+2-client.pem');
      // List<int> clientPem = dataP12.buffer.asUint8List();
      //
      // ByteData dataPemKey = await rootBundle.load('assets/certificates/localhost+2-client-key.pem');
      // List<int> clientPemKey = dataP12.buffer.asUint8List();

      SecurityContext sContext = SecurityContext();

      // sContext.setTrustedCertificatesBytes(serverP12, password: "changeit");
      // sContext.useCertificateChainBytes(clientPem, password: "changeit");
      // sContext.usePrivateKeyBytes(clientPemKey, password: "changeit");

      _httpClient = HttpClient(context: sContext);
    } on Exception {
      if (kDebugMode) {
        print(Exception);
      }
    }
  }
}