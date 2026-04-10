// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MissionModel _$MissionModelFromJson(Map<String, dynamic> json) =>
    _MissionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      reward: (json['reward'] as num).toInt(),
      type: $enumDecode(_$MissionTypeEnumMap, json['type']),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$MissionModelToJson(_MissionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'reward': instance.reward,
      'type': _$MissionTypeEnumMap[instance.type]!,
      'isCompleted': instance.isCompleted,
    };

const _$MissionTypeEnumMap = {
  MissionType.daily: 'daily',
  MissionType.weekly: 'weekly',
};
