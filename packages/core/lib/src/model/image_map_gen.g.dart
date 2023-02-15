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
    mapFiles:
        (json['map_files'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ImageMapGenToJson(ImageMapGen instance) =>
    <String, dynamic>{
      'output': instance.output,
      'map_files': instance.mapFiles,
    };
