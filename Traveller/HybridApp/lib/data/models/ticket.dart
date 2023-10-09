import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Ticket {
  Ticket(this.ticketId, this.seatId, this.trainId, this.startStation, this.endStation, this.startTime, this.endTime, this.platformNr, this.seatNr);

  final String ticketId;
  final String seatId;
  final String trainId;

  final String startStation;
  final String endStation;
  final String startTime;
  final String endTime;
  final String platformNr;
  final String seatNr;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
  Map<String, dynamic> toJson() => _$TicketToJson(this);
}