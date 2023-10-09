import 'package:traveller_app/data/models/search.dart';

abstract class RouteEvent {}

class GetRelevantRoutesEvent implements RouteEvent {
  final Search _search;

  Search get search => _search;

  GetRelevantRoutesEvent(this._search);
}
class GetAllRoutesEvent implements RouteEvent {}