import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap_metadata.dart';

part 'roadmap_metadata.freezed.dart';
part 'roadmap_metadata.g.dart';

@freezed
abstract class RoadmapMetadataModel with _$RoadmapMetadataModel {
  factory RoadmapMetadataModel({
    required String id,
    required String title,
    required String description,
    required int goalsCount,
    required String progress,
  }) = _RoadmapMetadataModel;

  factory RoadmapMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$RoadmapMetadataModelFromJson(json);

  factory RoadmapMetadataModel.fromEntity(RoadmapMetadata roadmapMetadata) {
    return RoadmapMetadataModel(
      id: roadmapMetadata.id,
      title: roadmapMetadata.title,
      description: roadmapMetadata.description,
      goalsCount: roadmapMetadata.goalsCount,
      progress: roadmapMetadata.progress,
    );
  }
}

extension RoadmapMetadataModelEntity on RoadmapMetadataModel {
  RoadmapMetadata toEntity() {
    return RoadmapMetadata(
      id: id,
      title: title,
      description: description,
      goalsCount: goalsCount,
      progress: progress,
    );
  }
}
