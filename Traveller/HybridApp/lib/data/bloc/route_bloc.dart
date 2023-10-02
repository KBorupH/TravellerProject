
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveller_app/data/bloc/events/route_events.dart';
import 'package:traveller_app/data/bloc/states/route_states.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  RouteBloc() : super(RouteState(state: RouteStates.initial)) {
    on<GetAllRoutesEvent>(_getAllRoutes);
  }

  // final _api = locator<IApiImages>(); //Using the locator to get the Api interface

  void _getAllRoutes(GetAllRoutesEvent event, Emitter<RouteState> emit) async {
    emit(RouteState(state: RouteStates.loading));

    List<int> imgs = [];
    try {
      // imgs = await _api.getAllImages();
    } on Exception {
      emit(RouteState(state: RouteStates.error));
    }

    emit(RouteState(state: RouteStates.complete, imgs: imgs));
  }
}