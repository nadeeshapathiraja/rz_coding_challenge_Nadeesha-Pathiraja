// GENERATED CODE - DO NOT MODIFY BY HAND

part of objects;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NBATeamModel _$NBATeamModelFromJson(Map<String, dynamic> json) => NBATeamModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imgUrl: json['imgUrl'] as String,
    );

Map<String, dynamic> _$NBATeamModelToJson(NBATeamModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imgUrl': instance.imgUrl,
    };

NBAUserModel _$NBAUserModelFromJson(Map<String, dynamic> json) => NBAUserModel(
      id: json['id'] as String,
      team_id: json['team_id'] as String,
      name: json['name'] as String,
      imgUrl: json['imgUrl'] as String,
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$NBAUserModelToJson(NBAUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'team_id': instance.team_id,
      'name': instance.name,
      'imgUrl': instance.imgUrl,
      'desc': instance.desc,
    };
