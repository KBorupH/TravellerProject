import 'dart:convert';
import 'dart:io';

import 'package:traveller_app/data/models/login.dart';
import 'package:traveller_app/data/models/train_route.dart';
import 'package:traveller_app/data/models/ticket.dart';
import 'package:traveller_app/interfaces/i_api_traveller.dart';
import 'package:http/http.dart' as http;

import '../models/search.dart';
import 'http_client_service.dart';
import 'http_token_service.dart';

class TravellerDataHttp implements IApiTraveller {

  late final HttpClientService _httpClientService;
  late final HttpTokenService _httpTokenService;
  late bool _isHttpInitialized = false;

  final String _baseURL = "http://test:20/";
  final String _routeEndPoint = "/route";

  Future<void> _initializeHttpService() async {
    if (_isHttpInitialized) return;

    _httpClientService = await HttpClientService().init();
    _httpTokenService = HttpTokenService(_httpClientService, _baseURL);
    _isHttpInitialized = true;
  }

  @override
  Future<bool> checkLogin(Login login) async {
    return await _httpTokenService.getRemoteAccessToken(login);
  }

  @override
  Future<List<TrainRoute>> getAllRoutes() async {
    await _initializeHttpService();
    final request = await _httpClientService.httpClient.getUrl(Uri.parse(_baseURL + _routeEndPoint));
    request.headers.add(HttpHeaders.contentTypeHeader, 'application/json');

    var response = await request.close();

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      String responseBody = await response.transform(utf8.decoder).join();

      List<TrainRoute> trainRoutes = (json.decode(responseBody) as List)
          .map((i) => TrainRoute.fromJson(i)).toList();

      return trainRoutes;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          '[ERROR] Failed to get - response code: ${response.statusCode}');
    }
  }

  @override
  Future<List<TrainRoute>> getRelevantRoutes(Search search) async {
    await _initializeHttpService();
    final request = await _httpClientService.httpClient.getUrl(Uri.parse(_baseURL + _routeEndPoint));
    request.headers.add(HttpHeaders.contentTypeHeader, 'application/json');
    request.add(utf8.encode(json.encode(search.toJson())));

    var response = await request.close();

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      String responseBody = await response.transform(utf8.decoder).join();

      List<TrainRoute> trainRoutes = (json.decode(responseBody) as List)
          .map((i) => TrainRoute.fromJson(i)).toList();

      return trainRoutes;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          '[ERROR] Failed to get - response code: ${response.statusCode}');
    }
  }

  @override
  Future<List<Ticket>> getAllTickets() async {
    await _initializeHttpService();
    String token = await _httpTokenService.getLocalAccessToken();
    final request = await _httpClientService.httpClient.getUrl(Uri.parse(_baseURL + _routeEndPoint));
    request.headers.add(HttpHeaders.contentTypeHeader, 'application/json');
    request.headers.add(HttpHeaders.authorizationHeader, "Bearer $token");

    var response = await request.close();

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      String responseBody = await response.transform(utf8.decoder).join();
      List<Ticket> tickets = (json.decode(responseBody) as List)
          .map((i) => Ticket.fromJson(i)).toList();

      return tickets;
    } else if (response.statusCode == 401) {
      // login again
      throw Exception('[ERROR] Unauthorized');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          '[ERROR] Failed to get - response code: ${response.statusCode}');
    }
  }

  @override
  Future<void> purchaseTicket(String routeId) async {
    await _initializeHttpService();
    String token = await _httpTokenService.getLocalAccessToken();
    final request = await _httpClientService.httpClient.postUrl(Uri.parse(_baseURL + _routeEndPoint));
    request.headers.add(HttpHeaders.contentTypeHeader, 'application/json');
    request.headers.add(HttpHeaders.authorizationHeader, "Bearer $token");

    var response = await request.close();


    if (response.statusCode == 200) {
      // If the server did return a 200 OK response

      return;
    } else if (response.statusCode == 401) {
      // login again
      throw Exception('[ERROR] Unauthorized');
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          '[ERROR] Failed to get - response code: ${response.statusCode}');
    }
  }
}