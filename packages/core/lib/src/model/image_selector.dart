import 'dart:io';

import 'package:image_map_core/src/utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recase/recase.dart';

part 'image_selector.g.dart';

enum ImageSelectorType {
  label,
  size,
  icon,
}

abstract class ImageSelector {
  const ImageSelector({required this.name, required this.type});
  @JsonKey(name: 'name', defaultValue: "image_selector")
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

  String classString(String parentName);
  String className(String parentName);

  // ignore: unused_element
  void _classOutput(
    StringBuffer buffer,
    String parentName,
    String assetsClassPath,
  );

  void classOutput(
    StringBuffer buffer,
    String parentName,
    String assetsClassPath,
  ) {
    switch (type) {
      case ImageSelectorType.label:
        (this as LabelSelector)._classOutput(
          buffer,
          parentName,
          assetsClassPath,
        );
        break;
      case ImageSelectorType.size:
        (this as SizeSelector)._classOutput(
          buffer,
          parentName,
          assetsClassPath,
        );
        break;
      case ImageSelectorType.icon:
        (this as IconSelector)._classOutput(
          buffer,
          parentName,
          assetsClassPath,
        );
        break;
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

  @override
  void _classOutput(
    StringBuffer buffer,
    String parentName,
    String assetsClassPath,
  ) {
    buffer.writeln(classString(parentName));
    for (var i = 0; i < children.length; i++) {
      children[i].classOutput(buffer, name, assetsClassPath);
    }
  }

  @override
  String classString(String parentName) => classStringGenerator(
        className(parentName),
        children
            .map((c) =>
                "${c.className(parentName)} get ${c.name} => ${c.className(parentName)}();")
            .join(" "),
      );

  @override
  String className(String parentName) {
    return '\$${name.pascalCase}LabelMap';
  }
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

  @override
  void _classOutput(
    StringBuffer buffer,
    String parentName,
    String assetsClassPath,
  ) {
    buffer.writeln(classString(parentName));
    for (var i = 0; i < children.length; i++) {
      children[i].classOutput(buffer, name, assetsClassPath);
    }
  }

  @override
  String classString(String parentName) {
    List<IconSelector> iconSelectors = children.cast<IconSelector>();
    return classStringGenerator(
      className(parentName),
      iconSelectors
          .map((c) =>
              "${childClassName(c.size)} get p${c.size} => ${childClassName(c.size)}();")
          .join(" "),
    );
  }

  @override
  String className(String parentName) => '\$${name.pascalCase}SizeMap';

  String childClassName(int size) => "\$${name.pascalCase}$size";
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

  @override
  void _classOutput(
    StringBuffer buffer,
    String parentName,
    String assetsClassPath,
  ) {
    stdout.writeln(assetsClassPath);
    buffer.writeln(classString(parentName));
  }

  String get content => "int get size => $size;";

  @override
  String classString(String parentName) => classStringGenerator(
        className(parentName),
        content,
      );

  @override
  String className(String parentName) => '\$${parentName.pascalCase}$size';
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
