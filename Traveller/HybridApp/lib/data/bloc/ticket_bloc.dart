
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traveller_app/data/bloc/events/route_events.dart';
import 'package:traveller_app/data/bloc/events/ticket_events.dart';
import 'package:traveller_app/data/bloc/states/route_states.dart';
import 'package:traveller_app/data/bloc/states/ticket_states.dart';
import 'package:traveller_app/interfaces/i_api_traveller.dart';

import '../../services/service_locator.dart';
import '../models/ticket.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketState(state: TicketStates.initial)) {
    on<GetAllTicketsEvent>(_getAllTickets);
    on<PurchaseTicketEvent>(_purchaseTicket);
  }

  final _api = locator<IApiTraveller>(); //Using the locator to get the Api interface

  void _getAllTickets(GetAllTicketsEvent event, Emitter<TicketState> emit) async {
    emit(TicketState(state: TicketStates.loading));

    List<Ticket> tickets = [];
    try {
      tickets = await _api.getAllTickets();
    } on Exception {
      emit(TicketState(state: TicketStates.error));
    }

    emit(TicketState(state: TicketStates.complete, tickets: tickets));
  }

  void _purchaseTicket(PurchaseTicketEvent event, Emitter<TicketState> emit) async {
    emit(TicketState(state: TicketStates.uploading));

    await _api.purchaseTicket(event.routeId);

    emit(TicketState(state: TicketStates.loading));
    List<Ticket> tickets = [];
    try {
      tickets = await _api.getAllTickets();
    } on Exception {
      emit(TicketState(state: TicketStates.error));
    }

    emit(TicketState(state: TicketStates.complete, tickets: tickets));
  }
}