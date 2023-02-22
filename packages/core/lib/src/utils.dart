typedef FileWriter = void Function(String contents, String path);

String get header => '''
/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  ImageMapGen
/// *****************************************************
///

''';

String get ignore => '''
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use  

''';

String import(String package) => 'import \'$package\';';

String classStringGenerator(String className, String content) => '''
class \$$className {
  const \$$className();

  $content
}
''';

enum ImageFileType {
  svg,
  rive,
  flare,
  lottie,
  common,
}

extension ImageFileTypeExtension on ImageFileType {
  String get genImageString {
    switch (this) {
      case ImageFileType.svg:
        return "SvgGenImage";
      case ImageFileType.rive:
        return "RiveGenImage";
      case ImageFileType.flare:
        return "FlareGenImage";
      case ImageFileType.lottie:
        return "LottieGenImage";
      case ImageFileType.common:
        return "AssetGenImage";
    }
  }
}

extension StringExtension on String {
  String get capitalize =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";

  String get fileName => split(".").first;

  ImageFileType get imageFileType {
    switch (split(".").last) {
      case "svg":
        return ImageFileType.svg;
      case "riv":
        return ImageFileType.rive;
      case "flr":
        return ImageFileType.flare;
      case "json":
        return ImageFileType.lottie;
      default:
        return ImageFileType.common;
    }
  }
}
