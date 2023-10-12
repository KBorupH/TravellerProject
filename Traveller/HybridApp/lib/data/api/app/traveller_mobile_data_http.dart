import 'dart:convert';
import 'dart:io';

import 'package:traveller_app/data/api/app/token_mobile_http_service.dart';
import 'package:traveller_app/data/models/login.dart';
import 'package:traveller_app/data/models/train_route.dart';
import 'package:traveller_app/data/models/ticket.dart';
import 'package:traveller_app/interfaces/i_api_traveller.dart';

import '../../models/search.dart';
import 'client_app_http_service.dart';

class TravellerMobileDataHttp implements IApiTraveller {

  late final ClientAppHttpService _httpClientService;
  late final TokenMobileHttpService _httpTokenService;
  late bool _isHttpInitialized = false;

  final String _baseURL = "https://10.108.149.13:3000/";

  final String _routesCtr = "routes/";
  final String _allRouteEndPoint = "all";
  final String _searchRoutesEndPoint = "search";

  final String _ticketsCtr = "tickets/";
  final String _allTicketsEndPoint = "all";
  final String _purchaseTicketEndPoint = "purchase";

  Future<void> _initializeHttpService() async {
    if (_isHttpInitialized) return;
    _httpClientService = await ClientAppHttpService().init();
    _httpTokenService = TokenMobileHttpService(_httpClientService, _baseURL);
    _isHttpInitialized = true;
  }

  @override
  Future<bool> checkLogin(Login login) async {
    return await _httpTokenService.getRemoteAccessToken(login, false);
  }

  @override
  Future<bool> register(Login login) async {
    return await _httpTokenService.getRemoteAccessToken(login, true);
  }

  @override
  Future<List<TrainRoute>> getAllRoutes() async {
    await _initializeHttpService();
    final request = await _httpClientService.httpClient.getUrl(Uri.parse(_baseURL + _routesCtr + _allRouteEndPoint));
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
    final request = await _httpClientService.httpClient.getUrl(Uri.parse(_baseURL + _routesCtr + _searchRoutesEndPoint));
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
    final request = await _httpClientService.httpClient.getUrl(Uri.parse(_baseURL + _ticketsCtr + _allTicketsEndPoint));
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
    final request = await _httpClientService.httpClient.postUrl(Uri.parse(_baseURL + _ticketsCtr + _purchaseTicketEndPoint));
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