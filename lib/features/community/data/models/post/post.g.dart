// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostModel _$PostModelFromJson(Map<String, dynamic> json) => _PostModel(
  id: json['id'] as String,
  roadmap: RoadmapModel.fromJson(json['roadmap'] as Map<String, dynamic>),
  bannerImage: json['bannerImage'] as String,
  author: PostAuthorModel.fromJson(json['author'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
  likes: (json['likes'] as num).toInt(),
  views: (json['views'] as num).toInt(),
);

Map<String, dynamic> _$PostModelToJson(_PostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roadmap': instance.roadmap,
      'bannerImage': instance.bannerImage,
      'author': instance.author,
      'createdAt': instance.createdAt.toIso8601String(),
      'likes': instance.likes,
      'views': instance.views,
    };
