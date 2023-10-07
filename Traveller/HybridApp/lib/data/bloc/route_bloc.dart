import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveller_app/data/bloc/events/route_events.dart';
import 'package:traveller_app/data/bloc/states/route_states.dart';
import 'package:traveller_app/data/models/train_route.dart';
import 'package:traveller_app/interfaces/i_api_traveller.dart';

import '../../services/service_locator.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  RouteBloc() : super(RouteState(state: RouteStates.initial)) {
    on<GetAllRoutesEvent>(_getAllRoutes);
    on<GetRelevantRoutesEvent>(_getRelevantRoutes);
  }

  final _api = locator<IApiTraveller>(); //Using the locator to get the Api interface

  void _getAllRoutes(GetAllRoutesEvent event, Emitter<RouteState> emit) async {
    emit(RouteState(state: RouteStates.loading));

    List<TrainRoute> routes = [];
    try {
      routes = await _api.getAllRoutes();
    } on Exception {
      emit(RouteState(state: RouteStates.error));
    }

    emit(RouteState(state: RouteStates.complete, routes: routes));
  }

  void _getRelevantRoutes(GetRelevantRoutesEvent event, Emitter<RouteState> emit) async {
    emit(RouteState(state: RouteStates.loading));

    List<TrainRoute> routes = [];
    try {
      routes = await _api.getRelevantRoutes(event.search);
    } on Exception {
      emit(RouteState(state: RouteStates.error));
    }

    emit(RouteState(state: RouteStates.complete, routes: routes));
  }
}


