import 'package:json_annotation/json_annotation.dart';

part 'image_selector.g.dart';

enum ImageSelectorType {
  label,
  size,
  icon,
}

abstract class ImageSelector {
  const ImageSelector({required this.name, required this.type});
  @JsonKey(name: 'name', required: true)
  final String name;
  @JsonKey(name: 'type', required: true)
  final ImageSelectorType type;

  factory ImageSelector.fromType(Map<String, dynamic> json) {
    switch ($enumDecode(_$ImageSelectorTypeEnumMap, json['type'])) {
      case ImageSelectorType.label:
        return LabelSelector.fromJson(json);
      case ImageSelectorType.size:
        return SizeSelector.fromJson(json);
      case ImageSelectorType.icon:
        return IconSelector.fromJson(json);
    }
  }
}

@JsonSerializable(explicitToJson: true)
class LabelSelector extends ImageSelector {
  const LabelSelector({
    required super.name,
    required super.type,
    required this.children,
  });

  @JsonKey(
      name: 'children',
      required: true,
      fromJson: childrenFromJson,
      toJson: childrenToJson)
  final List<ImageSelector> children;

  factory LabelSelector.fromJson(Map<String, dynamic> json) =>
      _$LabelSelectorFromJson(json);
  Map<String, dynamic> toJson() => _$LabelSelectorToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SizeSelector extends ImageSelector {
  const SizeSelector({
    required super.name,
    required super.type,
    required this.children,
  });

  @JsonKey(
      name: 'children',
      required: true,
      fromJson: childrenFromJson,
      toJson: childrenToJson)
  final List<ImageSelector> children;

  factory SizeSelector.fromJson(Map<String, dynamic> json) =>
      _$SizeSelectorFromJson(json);
  Map<String, dynamic> toJson() => _$SizeSelectorToJson(this);
}

@JsonSerializable(explicitToJson: true)
class IconSelector extends ImageSelector {
  const IconSelector({
    required super.name,
    required super.type,
    required this.size,
    required this.light,
    this.dark,
  });

  @JsonKey(name: 'size', required: true)
  final int size;

  @JsonKey(name: 'light', required: true)
  final String light;

  @JsonKey(name: 'dark')
  final String? dark;

  factory IconSelector.fromJson(Map<String, dynamic> json) =>
      _$IconSelectorFromJson(json);
  Map<String, dynamic> toJson() => _$IconSelectorToJson(this);
}

List<ImageSelector> childrenFromJson(List<dynamic> json) => json.map((e) {
      return ImageSelector.fromType(e);
    }).toList();

List<Map<String, dynamic>> childrenToJson(List<ImageSelector> categories) {
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
