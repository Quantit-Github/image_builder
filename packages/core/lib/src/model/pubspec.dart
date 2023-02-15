import 'package:json_annotation/json_annotation.dart';

part 'pubspec.g.dart';

@JsonSerializable(explicitToJson: true)
class Pubspec {
  Pubspec({
    required this.packageName,
    required this.imageMapGen,
  });

  @JsonKey(name: 'name', required: true)
  final String packageName;

  @JsonKey(name: 'image_map_gen', required: true)
  final ImageMapGen imageMapGen;

  factory Pubspec.fromJson(Map<String, dynamic> json) =>
      _$PubspecFromJson(json);

  Map<String, dynamic> toJson() => _$PubspecToJson(this);
}

@JsonSerializable()
class ImageMapGen {
  const ImageMapGen({required this.output, required this.map});

  @JsonKey(name: 'output', required: true)
  final String output;

  @JsonKey(name: 'map', required: true)
  final List<String> map;

  factory ImageMapGen.fromJson(Map<String, dynamic> json) =>
      _$ImageMapGenFromJson(json);

  Map<String, dynamic> toJson() => _$ImageMapGenToJson(this);
}
