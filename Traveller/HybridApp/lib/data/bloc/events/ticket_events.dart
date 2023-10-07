abstract class TicketEvent {}

class PurchaseTicketEvent implements TicketEvent {
  final String _routeId;

  String get routeId => _routeId;

  PurchaseTicketEvent(this._routeId);
}
class GetAllTicketsEvent implements TicketEvent {}