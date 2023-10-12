import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Ticket {
  Ticket(this.ticketId, this.seatId, this.trainId, this.startStation, this.endStation, this.startTime, this.endTime, this.platformNr);

  final String ticketId;
  final String seatId;
  final String trainId;

  @JsonKey(includeToJson: false)
  final String startStation;
  @JsonKey(includeToJson: false)
  final String endStation;
  @JsonKey(includeToJson: false)
  final String startTime;
  @JsonKey(includeToJson: false)
  final String endTime;
  @JsonKey(includeToJson: false)
  final String platformNr;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
  Map<String, dynamic> toJson() => _$TicketToJson(this);
}