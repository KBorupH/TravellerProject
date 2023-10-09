// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'train_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainRoute _$TrainRouteFromJson(Map<String, dynamic> json) => TrainRoute(
      json['id'] as String,
      json['start_station'] as String,
      json['end_station'] as String,
      json['start_time'] as String,
      json['end_time'] as String,
    );

Map<String, dynamic> _$TrainRouteToJson(TrainRoute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_station': instance.startStation,
      'end_station': instance.endStation,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
    };
