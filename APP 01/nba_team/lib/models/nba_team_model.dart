part of 'objects.dart';

@JsonSerializable()
class NBATeamModel {
  late String id;
  late String name;
  late String imgUrl;

  NBATeamModel({
    required this.id,
    required this.name,
    required this.imgUrl,
  });

  factory NBATeamModel.fromJson(Map<String, dynamic> json) =>
      _$NBATeamModelFromJson(json);

  Map<String, dynamic> toJson() => _$NBATeamModelToJson(this);
}
