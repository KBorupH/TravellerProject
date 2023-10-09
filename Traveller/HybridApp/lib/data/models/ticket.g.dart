// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      json['ticket_id'] as String,
      json['seat_id'] as String,
      json['train_id'] as String,
      json['start_station'] as String,
      json['end_station'] as String,
      json['start_time'] as String,
      json['end_time'] as String,
      json['platform_nr'] as String,
      json['seat_nr'] as String,
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'ticket_id': instance.ticketId,
      'seat_id': instance.seatId,
      'train_id': instance.trainId,
      'start_station': instance.startStation,
      'end_station': instance.endStation,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'platform_nr': instance.platformNr,
      'seat_nr': instance.seatNr,
    };
