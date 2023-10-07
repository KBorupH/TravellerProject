import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller_app/_app_lib/app_page.dart';
import 'package:traveller_app/_web_lib/web_main.dart';
import '../../data/bloc/events/ticket_events.dart';
import '../../data/bloc/ticket_bloc.dart';
import '../../data/models/train_route.dart' as models;


class RouteWidget extends StatefulWidget {
  const RouteWidget(
      {super.key,
      required this.route});

  final models.TrainRoute route;

  @override
  State<RouteWidget> createState() => _RouteWidgetState();
}

class _RouteWidgetState extends State<RouteWidget> {

  @override
  Widget build(BuildContext context) {
    final TicketBloc ticketBloc = BlocProvider.of<TicketBloc>(context);

    return Card(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.route.startStation, style: const TextStyle(fontSize: 25)),
                Text(widget.route.endStation, style: const TextStyle(fontSize: 25))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.route.startTime, style: const TextStyle(fontSize: 20)),
                Text(widget.route.endTime, style: const TextStyle(fontSize: 20))
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 5, height: 5,),
              IconButton(
                  onPressed: () {
                    //Open all destinations on route
                  },
                  icon: const Icon(Icons.keyboard_arrow_down)),
              IconButton(
                  onPressed: () {
                    ticketBloc.add(PurchaseTicketEvent(widget.route.id));

                    //Go to tickets page, agnostic of platform
                    if (kIsWeb) { // running on the web!
                      context.go(WebPages.ticket.toPath);
                    } else {
                      appPageNotifier.changePage(AppPages.ticket);
                    }
                  },
                  icon: const Icon(Icons.add))
            ],)

          ],
        ),
      ),
    );
  }
}
