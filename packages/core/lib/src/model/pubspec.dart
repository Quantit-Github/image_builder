import 'package:image_map_core/src/model/image_map_gen.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pubspec.g.dart';

@JsonSerializable(explicitToJson: true)
class Pubspec {
  Pubspec(
      {required this.packageName,
      required this.imageMapGen,
      required this.flutterGen,
      required this.flutter});

  @JsonKey(name: 'name', required: true)
  final String packageName;

  @JsonKey(name: 'image_map_gen', required: true)
  final ImageMapGen imageMapGen;

  @JsonKey(name: 'flutter_gen', required: true)
  final FlutterGen flutterGen;

  @JsonKey(name: 'flutter', required: true)
  final Flutter flutter;

  factory Pubspec.fromJson(Map<String, dynamic> json) =>
      _$PubspecFromJson(json);

  Map<String, dynamic> toJson() => _$PubspecToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FlutterGen {
  const FlutterGen({required this.output, required this.lineLength});

  @JsonKey(name: 'output', required: true, defaultValue: "lib/gen/")
  final String output;

  @JsonKey(name: 'line_length', required: true, defaultValue: 80)
  final int lineLength;

  factory FlutterGen.fromJson(Map<String, dynamic> json) =>
      _$FlutterGenFromJson(json);
  Map<String, dynamic> toJson() => _$FlutterGenToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Flutter {
  const Flutter({required this.assets});

  @JsonKey(name: 'assets', required: true)
  final List<String> assets;

  factory Flutter.fromJson(Map<String, dynamic> json) =>
      _$FlutterFromJson(json);
  Map<String, dynamic> toJson() => _$FlutterToJson(this);
}
