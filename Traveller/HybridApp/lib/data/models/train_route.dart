import 'package:json_annotation/json_annotation.dart';

part 'train_route.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TrainRoute {
  TrainRoute(this.id, this.startStation, this.endStation, this.startTime, this.endTime);

  final String id;

  final String startStation;
  final String endStation;
  final String startTime;
  final String endTime;

  factory TrainRoute.fromJson(Map<String, dynamic> json) => _$TrainRouteFromJson(json);
  Map<String, dynamic> toJson() => _$TrainRouteToJson(this);
}