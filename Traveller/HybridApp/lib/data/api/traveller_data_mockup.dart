import 'package:flutter/scheduler.dart';


import '../MockupData/models/mockup_data_models.dart';
import '../models/route.dart';

class TravellerDataMockup {
  List<Route> routes = [

  ];

  List<Passenger> passengers = [

  ];

  List<Ticket> tickets = [

  ];

  Future<List<Route>> getAllRoutes() async {
    return await [];
  }

  Future<List<Ticket>> getAllTickets() async {
    return await [];
  }

  Future<List<Ticket>> checkLogin() async {
    return await [];
  }
}