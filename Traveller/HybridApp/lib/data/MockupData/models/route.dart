import 'mockup_data_models.dart';

class Route {
  Route(this.id, this.destination, this.train);

  final String id;
  final List<Destination> destination;
  final Train train;
}