// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_map_gen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageMapGen _$ImageMapGenFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['output', 'map_files'],
  );
  return ImageMapGen(
    output: json['output'] as String,
    mapFiles: (json['map_files'] as List<dynamic>)
        .map((e) => ImageGenMapFile.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ImageMapGenToJson(ImageMapGen instance) =>
    <String, dynamic>{
      'output': instance.output,
      'map_files': instance.mapFiles.map((e) => e.toJson()).toList(),
    };

ImageGenMapFile _$ImageGenMapFileFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['path', 'category'],
  );
  return ImageGenMapFile(
    path: json['path'] as String,
    category: categoryFromJson(json['category'] as List),
  );
}

Map<String, dynamic> _$ImageGenMapFileToJson(ImageGenMapFile instance) =>
    <String, dynamic>{
      'path': instance.path,
      'category': categoryToJson(instance.category),
    };
