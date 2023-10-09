import 'package:traveller_app/data/models/train_route.dart';

enum RouteStates { initial, uploading, loading, deleting, complete, error }

class RouteState {
  final RouteStates _state;
  final List<TrainRoute> _routes;

  RouteStates get currentState => _state;

  List<TrainRoute> get routes => _routes;

  RouteState({required RouteStates state, List<TrainRoute>? routes})
      : _state = state,
        _routes = routes ?? [];
}