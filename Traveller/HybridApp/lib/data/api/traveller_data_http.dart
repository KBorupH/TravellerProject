import 'package:traveller_app/data/models/login.dart';
import 'package:traveller_app/data/models/train_route.dart';
import 'package:traveller_app/data/models/ticket.dart';
import 'package:traveller_app/interfaces/i_api_traveller.dart';
import 'package:http/http.dart' as http;

class TravellerDataHttp implements IApiTraveller {
  final String _baseURL = "http://test:20/";
  final String _routeEndPoint = "/route";

  @override
  Future<List<TrainRoute>> getAllRoutes() async {
    final response = await http.get(Uri.parse(_baseURL + _routeEndPoint));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // List<ImageModel> imgMdls = (json.decode(response.body) as List)
      //     .map((i) => ImageModel.fromJson(i)).toList();

      return  [
        TrainRoute("1","Ringsted","Køge","08:20","08:40"),
        TrainRoute("2","København H","Odense","18:30","20:40"),
        TrainRoute("3","Skagen","Aarhus","14:10","17:50"),
        TrainRoute("4","Sorø","Næstved","09:45","11:15"),
        TrainRoute("5","Sorø","Næstved","09:45","11:15"),
        TrainRoute("4","Sorø","Næstved","09:45","11:15"),
        TrainRoute("4","Sorø","Næstved","09:45","11:15"),
        TrainRoute("4","Sorø","Næstved","09:45","11:15"),
        TrainRoute("4","Sorø","Næstved","09:45","11:15"),
        TrainRoute("4","Sorø","Næstved","09:45","11:15"),
        TrainRoute("4","Sorø","Næstved","09:45","11:15"),
        TrainRoute("4","Sorø","Næstved","09:45","11:15"),
        TrainRoute("4","Sorø","Næstved","09:45","11:15"),
        TrainRoute("4","Sorø","Næstved","09:45","11:15"),
      ];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          '[ERROR] Failed to get - response code: ${response.statusCode}');
    }
  }

  @override
  Future<bool> checkLogin(Login login) {
    // TODO: implement checkLogin
    throw UnimplementedError();
  }

  @override
  Future<List<Ticket>> getAllTickets() async {
    return await [
      Ticket("", "", "", "Ringsted", "Køge", "08:20", "08:40", "4", "231"),
      Ticket("", "", "", "København H", "Odense", "18:30", "20:40", "1", "043"),
      Ticket("", "", "", "Skagen", "Aarhus", "14:10", "17:50", "5", "114"),
      Ticket("", "", "", "Sorø", "Næstved", "09:45", "11:15", "2", "325"),
      Ticket("", "", "", "Næstved", "Sorø", "11:15 ", "09:45", "3", "314"),
      Ticket("", "", "", "Sorø", "Skagen", "09:45", "15:54", "5", "201")
    ];
  }

  @override
  Future<List<TrainRoute>> getRelevantRoutes() {
    // TODO: implement getRelevantRoutes
    throw UnimplementedError();
  }

  @override
  Future<TrainRoute> getTicketRoute(String ticketId) {
    // TODO: implement getTicketRoute
    throw UnimplementedError();
  }

  @override
  Future<TrainRoute> purchaseTicket(String routeId) {
    // TODO: implement purchaseTicket
    throw UnimplementedError();
  }
}