import 'package:traveller_app/data/models/login.dart';
import 'package:traveller_app/data/models/search.dart';

import '../data/models/train_route.dart';
import '../data/models/ticket.dart';

abstract class IApiTraveller {
  Future<List<TrainRoute>> getAllRoutes();
  Future<List<TrainRoute>> getRelevantRoutes(Search search);
  Future<void> purchaseTicket(String routeId);
  Future<List<Ticket>> getAllTickets();
  Future<bool> checkLogin(Login login);
}

