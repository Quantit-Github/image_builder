// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pubspec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pubspec _$PubspecFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'image_map_gen'],
  );
  return Pubspec(
    packageName: json['name'] as String,
    imageMapGen:
        ImageMapGen.fromJson(json['image_map_gen'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PubspecToJson(Pubspec instance) => <String, dynamic>{
      'name': instance.packageName,
      'image_map_gen': instance.imageMapGen.toJson(),
    };

ImageMapGen _$ImageMapGenFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['output', 'map'],
  );
  return ImageMapGen(
    output: json['output'] as String,
    map: (json['map'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ImageMapGenToJson(ImageMapGen instance) =>
    <String, dynamic>{
      'output': instance.output,
      'map': instance.map,
    };
