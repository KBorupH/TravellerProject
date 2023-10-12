import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveller_app/_common_lib/widgets/route_widget.dart';
import 'package:traveller_app/data/bloc/events/route_events.dart';
import 'package:traveller_app/data/bloc/states/route_states.dart';

import '../../data/bloc/route_bloc.dart';

class RoutesScrollWidget extends StatefulWidget {
  const RoutesScrollWidget({super.key});

  @override
  State<RoutesScrollWidget> createState() => _RoutesScrollWidgetState();
}

class _RoutesScrollWidgetState extends State<RoutesScrollWidget> {
  late bool _routesLoading = true;

  @override
  void initState() {
    super.initState();
    final RouteBloc routeBloc = BlocProvider.of<RouteBloc>(context);
    routeBloc.add(GetAllRoutesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RouteBloc, RouteState>(
      listener: (listenContext, state) {
        setState(() {
          if (state.currentState == RouteStates.complete) {
            _routesLoading = false;
          } else {
            _routesLoading = true;
          }
        });
      },
      child: _routesLoading
          ? const CircularProgressIndicator()
          : BlocBuilder<RouteBloc, RouteState>(
              builder: (blocContext, RouteState state) {
                return SingleChildScrollView(
                  child: Column(
                    children: state.routes
                        .map(
                          (route) => RouteWidget(route: route),
                        )
                        .toList(),
                  ),
                );
              },
            ),
    );
  }
}
