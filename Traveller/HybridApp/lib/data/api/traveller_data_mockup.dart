import 'package:traveller_app/data/models/login.dart';
import 'package:traveller_app/data/models/search.dart';
import 'package:traveller_app/data/models/train_route.dart';
import 'package:traveller_app/data/models/ticket.dart';
import 'package:traveller_app/interfaces/i_api_traveller.dart';
import 'package:http/http.dart' as http;

class TravellerDataMockup implements IApiTraveller {
  final String _baseURL = "http://test:20/";
  final String _routeEndPoint = "/route";

  @override
  Future<List<TrainRoute>> getAllRoutes() async {
    return [
      TrainRoute("1", "Ringsted", "Køge", "08:20", "08:40"),
      TrainRoute("2", "København H", "Odense", "18:30", "20:40"),
      TrainRoute("3", "Skagen", "Aarhus", "14:10", "17:50"),
      TrainRoute("4", "Sorø", "Næstved", "09:45", "11:15"),
      TrainRoute("5", "Helsingør St.", "Næstved", "09:45", "11:15"),
      TrainRoute("6", "Sorø", "Næstved", "09:45", "11:15"),
      TrainRoute("4", "Sorø", "Næstved", "09:45", "11:15"),
      TrainRoute("4", "Sorø", "Næstved", "09:45", "11:15"),
      TrainRoute("4", "Sorø", "Næstved", "09:45", "11:15"),
      TrainRoute("4", "Sorø", "Næstved", "09:45", "11:15"),
      TrainRoute("4", "Sorø", "Næstved", "09:45", "11:15"),
      TrainRoute("4", "Sorø", "Næstved", "09:45", "11:15"),
      TrainRoute("4", "Sorø", "Næstved", "09:45", "11:15"),
      TrainRoute("4", "Sorø", "Næstved", "09:45", "11:15"),
    ];
  }

  @override
  Future<List<Ticket>> getAllTickets() async {
    return await [
      Ticket("1", "123", "1", "Ringsted", "Køge", "08:20", "08:40", "4", ),
      Ticket("2", "345", "1", "København H", "Odense", "18:30", "20:40", "1"),
      Ticket("3", "113", "1", "Skagen", "Aarhus", "14:10", "17:50", "5"),
      Ticket("4", "432", "1", "Sorø", "Næstved", "09:45", "11:15", "2"),
      Ticket("5", "153", "1", "Næstved", "Sorø", "11:15 ", "09:45", "3"),
      Ticket("6", "172", "1", "Sorø", "Skagen", "09:45", "15:54", "5")
    ];
  }

  @override
  Future<List<TrainRoute>> getRelevantRoutes(Search search) async {
    var routes = await getAllRoutes();
    return routes
        .where((element) =>
            element.startStation == search.startStation &&
            element.endStation == search.endStation)
        .toList();
  }

  @override
  Future<void> purchaseTicket(String routeId) async {}

  @override
  Future<bool> checkLogin(Login login) async {
    if (login.email == "test" && login.password == "test") return await true;
    return false;
  }
}
