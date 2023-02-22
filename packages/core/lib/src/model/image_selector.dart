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
  String classNameString(String parentName) =>
      "${className(parentName)}${type.name.pascalCase}Map";

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
    String cn = className(parentName);
    for (var i = 0; i < children.length; i++) {
      children[i].classOutput(buffer, cn, assetsClassPath);
    }
  }

  String getParentName(String parentName) =>
      parentName.isEmpty ? name : parentName;

  @override
  String classString(String parentName) {
    String pn = getParentName(parentName);
    return classStringGenerator(
      classNameString(pn),
      children
          .map((c) =>
              "\$${c.classNameString(pn)} get ${c.name} => \$${c.classNameString(pn)}();")
          .join(" "),
    );
  }

  @override
  String className(String parentName) {
    if (parentName == name) {
      return name.pascalCase;
    } else {
      return '${parentName.pascalCase}${name.pascalCase}';
    }
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
    String cn = className(parentName);
    for (var i = 0; i < children.length; i++) {
      children[i].classOutput(buffer, cn, assetsClassPath);
    }
  }

  @override
  String classString(String parentName) {
    List<IconSelector> iconSelectors = children.cast<IconSelector>();
    String cn = className(parentName);
    return classStringGenerator(
      classNameString(parentName),
      iconSelectors
          .map((c) =>
              "\$${c.classNameString(cn)} get p${c.size} => \$${c.classNameString(cn)}();")
          .join(" "),
    );
  }

  @override
  String className(String parentName) =>
      '${parentName.pascalCase}${name.pascalCase}';
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
    String classStringBase = classString(parentName);
    classStringBase =
        classStringBase.replaceAll("#light", lightString(assetsClassPath));
    classStringBase =
        classStringBase.replaceAll("#dark", darkString(assetsClassPath));
    buffer.writeln(classStringBase);
  }

  String get content => "int get size => $size; #light #dark";

  String lightString(String assetsClassPath) =>
      "${light.imageFileType.genImageString} get light => $assetsClassPath.${light.fileName.camelCase};";

  String darkString(String assetsClassPath) {
    if (dark == null) {
      return "${light.imageFileType.genImageString} get dark => light;";
    } else {
      return "${dark!.imageFileType.genImageString} get dark => $assetsClassPath.${dark!.fileName.camelCase};";
    }
  }

  @override
  String classString(String parentName) => classStringGenerator(
        classNameString(parentName),
        content,
      );

  @override
  String className(String parentName) => '${parentName.pascalCase}$size';
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
