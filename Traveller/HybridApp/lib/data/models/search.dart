import 'package:json_annotation/json_annotation.dart';

part 'search.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Search {
  Search(this.startStation, this.endStation, this.endTime);

  final String startStation;
  final String endStation;
  final String endTime;

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
  Map<String, dynamic> toJson() => _$SearchToJson(this);
}