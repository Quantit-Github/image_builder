import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart';

part 'image_map_gen.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageMapGen {
  const ImageMapGen({required this.output, required this.mapFiles});

  @JsonKey(name: 'output', required: true)
  final String output;

  @JsonKey(name: 'map_files', required: true)
  final List<String> mapFiles;

  factory ImageMapGen.fromJson(Map<String, dynamic> json) =>
      _$ImageMapGenFromJson(json);

  Map<String, dynamic> toJson() => _$ImageMapGenToJson(this);

  List<String> get outputFilePathList =>
      mapFiles.map<String>(packOutputPath).toList();

  String packOutputPath(String mapFilePath) {
    File mapFile = File(mapFilePath);
    String filename = basename(mapFile.path).split(".")[0];
    return "$output$filename.map.dart";
  }
}
