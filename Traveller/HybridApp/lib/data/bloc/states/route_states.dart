enum RouteStates { initial, uploading, loading, deleting, complete, error }

class RouteState {
  final RouteStates _state;
  final List<int> _imgs;

  RouteStates get currentState => _state;

  List<int> get imgs => _imgs;

  RouteState({required RouteStates state, List<int>? imgs})
      : _state = state,
        _imgs = imgs ?? [];
}