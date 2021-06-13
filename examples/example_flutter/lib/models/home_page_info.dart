import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kin_base/base/models/kin_amount.dart';
import 'activity.dart';
part 'home_page_info.g.dart';

@JsonSerializable()
class HomePageInfo extends Equatable {
  @JsonKey(name: 'amount')
  final KinAmount amount;
  @JsonKey(name: 'activities')
  final List<Activity> activities;

  HomePageInfo({this.amount, this.activities = const []});

  factory HomePageInfo.fromJson(Map<String, dynamic> json) =>
      _$HomePageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$HomePageInfoToJson(this);

  // Equatable
  @override
  List<Object> get props => [amount, activities];

  @override
  String toString() => 'Home page data { id: $amount }';
}
