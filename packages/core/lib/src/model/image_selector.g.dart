// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_selector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabelSelector _$LabelSelectorFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['type', 'children'],
  );
  return LabelSelector(
    name: json['name'] as String? ?? 'image_selector',
    type: $enumDecode(_$ImageSelectorTypeEnumMap, json['type']),
    children: childrenFromJson(json['children'] as List),
  );
}

Map<String, dynamic> _$LabelSelectorToJson(LabelSelector instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$ImageSelectorTypeEnumMap[instance.type]!,
      'children': childrenToJson(instance.children),
    };

const _$ImageSelectorTypeEnumMap = {
  ImageSelectorType.label: 'label',
  ImageSelectorType.size: 'size',
  ImageSelectorType.icon: 'icon',
};

SizeSelector _$SizeSelectorFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['type', 'children'],
  );
  return SizeSelector(
    name: json['name'] as String? ?? 'image_selector',
    type: $enumDecode(_$ImageSelectorTypeEnumMap, json['type']),
    children: childrenFromJson(json['children'] as List),
  );
}

Map<String, dynamic> _$SizeSelectorToJson(SizeSelector instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$ImageSelectorTypeEnumMap[instance.type]!,
      'children': childrenToJson(instance.children),
    };

IconSelector _$IconSelectorFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['type', 'size', 'light'],
  );
  return IconSelector(
    name: json['name'] as String? ?? 'image_selector',
    type: $enumDecode(_$ImageSelectorTypeEnumMap, json['type']),
    size: json['size'] as int,
    light: json['light'] as String,
    dark: json['dark'] as String?,
  );
}

Map<String, dynamic> _$IconSelectorToJson(IconSelector instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$ImageSelectorTypeEnumMap[instance.type]!,
      'size': instance.size,
      'light': instance.light,
      'dark': instance.dark,
    };
