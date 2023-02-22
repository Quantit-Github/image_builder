// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pubspec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pubspec _$PubspecFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'image_map_gen', 'flutter_gen', 'flutter'],
  );
  return Pubspec(
    packageName: json['name'] as String,
    imageMapGen:
        ImageMapGen.fromJson(json['image_map_gen'] as Map<String, dynamic>),
    flutterGen:
        FlutterGen.fromJson(json['flutter_gen'] as Map<String, dynamic>),
    flutter: Flutter.fromJson(json['flutter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PubspecToJson(Pubspec instance) => <String, dynamic>{
      'name': instance.packageName,
      'image_map_gen': instance.imageMapGen.toJson(),
      'flutter_gen': instance.flutterGen.toJson(),
      'flutter': instance.flutter.toJson(),
    };

FlutterGen _$FlutterGenFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['output', 'line_length'],
  );
  return FlutterGen(
    output: json['output'] as String? ?? 'lib/gen/',
    lineLength: json['line_length'] as int? ?? 80,
  );
}

Map<String, dynamic> _$FlutterGenToJson(FlutterGen instance) =>
    <String, dynamic>{
      'output': instance.output,
      'line_length': instance.lineLength,
    };

Flutter _$FlutterFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['assets'],
  );
  return Flutter(
    assets: (json['assets'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$FlutterToJson(Flutter instance) => <String, dynamic>{
      'assets': instance.assets,
    };
