import 'package:traveller_app/data/models/ticket.dart';

enum TicketStates { initial, uploading, loading, deleting, complete, error }

class TicketState {
  final TicketStates _state;
  final List<Ticket> _tickets;

  TicketStates get currentState => _state;

  List<Ticket> get tickets => _tickets;

  TicketState({required TicketStates state, List<Ticket>? tickets})
      : _state = state,
        _tickets = tickets ?? [];
}