part of 'objects.dart';

@JsonSerializable()
class NBAUserModel {
  late String id;
  late String team_id;
  late String name;
  late String imgUrl;
  late String desc;

  NBAUserModel({
    required this.id,
    required this.team_id,
    required this.name,
    required this.imgUrl,
    required this.desc,
  });

  factory NBAUserModel.fromJson(Map<String, dynamic> json) =>
      _$NBAUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$NBAUserModelToJson(this);
}
