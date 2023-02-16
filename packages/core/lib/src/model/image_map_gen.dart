import 'dart:io';

import 'package:image_map_core/src/config.dart';
import 'package:image_map_core/src/model/image_selector.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recase/recase.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

part 'image_map_gen.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageMapGen {
  const ImageMapGen({required this.output, required this.mapFiles});

  @JsonKey(name: 'output', required: true)
  final String output;

  @JsonKey(name: 'map_files', required: true)
  final List<ImageGenMapFile> mapFiles;

  factory ImageMapGen.fromJson(Map<String, dynamic> json) {
    return ImageMapGen(
      output: json['output'] as String,
      mapFiles: (json['map_files'] as List<dynamic>)
          .map((e) => ImageGenMapFile.fromPath(e as String))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$ImageMapGenToJson(this);

  List<String> get outputFilePathList =>
      mapFiles.map<String>(packOutputPath).toList();

  String packOutputPath(ImageGenMapFile mapFilePath) =>
      "$output${mapFilePath.fileName}";
}

@JsonSerializable(explicitToJson: true)
class ImageGenMapFile {
  const ImageGenMapFile({required this.path, required this.category});

  @JsonKey(name: 'path', required: true)
  final String path;

  @JsonKey(
      name: 'category',
      required: true,
      fromJson: categoryFromJson,
      toJson: categoryToJson)
  final List<ImageSelector> category;

  factory ImageGenMapFile.fromPath(String path) {
    File mapFile = File(path);
    YamlMap doc = loadYaml(mapFile.readAsStringSync()) as YamlMap;
    Map<String, dynamic> map = doc.toMap();
    return ImageGenMapFile.fromJson(map);
  }

  factory ImageGenMapFile.fromJson(Map<String, dynamic> json) =>
      _$ImageGenMapFileFromJson(json);

  Map<String, dynamic> toJson() => _$ImageGenMapFileToJson(this);

  String get fileName => "${path.snakeCase}.map.dart";
}

List<ImageSelector> categoryFromJson(List<dynamic> json) => json.map((e) {
      return ImageSelector.fromType(e);
    }).toList();

List<Map<String, dynamic>> categoryToJson(List<ImageSelector> categories) {
  return categories.map((instance) {
    switch (instance.type) {
      case ImageSelectorType.label:
        return (instance as LabelSelector).toJson();
      case ImageSelectorType.size:
        return (instance as SizeSelector).toJson();
      case ImageSelectorType.icon:
        return (instance as IconSelector).toJson();
    }
  }).toList();
}
