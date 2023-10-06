import 'package:traveller_app/data/models/login.dart';

import '../data/models/train_route.dart';
import '../data/models/ticket.dart';

abstract class IApiTraveller {
  Future<List<TrainRoute>> getAllRoutes();
  Future<List<TrainRoute>> getRelevantRoutes();
  Future<TrainRoute> purchaseTicket(String routeId);
  Future<TrainRoute> getTicketRoute(String ticketId);
  Future<List<Ticket>> getAllTickets();
  Future<bool> checkLogin(Login login);
}

