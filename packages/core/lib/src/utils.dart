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
class $className {
  static final $className _instance = $className._internal();
  factory $className() => _instance;
  $className._internal() {
    debugPrint("${className.replaceAll("\$", "\\\$")} Class Created");
  }
  $content
}
''';
