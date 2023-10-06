// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Search _$SearchFromJson(Map<String, dynamic> json) => Search(
      json['start_station'] as String,
      json['end_station'] as String,
      json['end_time'] as String,
    );

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'start_station': instance.startStation,
      'end_station': instance.endStation,
      'end_time': instance.endTime,
    };
