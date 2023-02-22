import 'dart:io';
import 'package:image_map_core/src/model/pubspec.dart';
import 'package:image_map_core/src/utils.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

class Config {
  const Config({
    required this.pubspecFile,
    required this.pubspec,
  });
  final File pubspecFile;
  final Pubspec pubspec;

  factory Config.fromFile(File pubspecFile) {
    YamlMap doc = loadYaml(pubspecFile.readAsStringSync()) as YamlMap;
    Map<String, dynamic> pubspecMap = doc.toMap();
    return Config(
      pubspecFile: pubspecFile,
      pubspec: Pubspec.fromJson(pubspecMap),
    );
  }

  // 에셋에 설정 했는지 체크
  bool get checkSetAssets {
    List<String> pathInMapFiles =
        pubspec.imageMapGen.mapFiles.map((e) => e.path).toList();

    List<String> notContainPath = pathInMapFiles
        .where((element) => !pubspec.flutter.assets.contains(element))
        .toList();

    if (notContainPath.isEmpty) {
      return false;
    } else {
      String errorString = """
  Error:  
    map yaml 파일에 설정된 path가 assets에 설정 되어 있지 않습니다.
    확인해주세요.
  Path List:
    [ ${notContainPath.join(", ")} ]
""";
      stdout.writeln(errorString);
      return true;
    }
  }

  String get flutterGenAssetsFilePath => normalize(
        join(
          pubspecFile.parent.path,
          "${pubspec.flutterGen.output}/assets.gen.dart",
        ),
      );

  String get imageGenOutputPath =>
      normalize(join(pubspecFile.parent.path, pubspec.imageMapGen.output));

  StringBuffer generateStringBuffer() {
    final buffer = StringBuffer();
    buffer.writeln(header);
    buffer.writeln(ignore);

    final List<String> imports = [
      // "package:flutter/widgets.dart",
      "${pubspec.flutterGen.output.replaceAll("lib", "package:${pubspec.packageName}")}assets.gen.dart",
    ];
    for (String package in imports) {
      buffer.writeln(import(package));
    }

    return buffer;
  }
}

extension YamlMapConverter on YamlMap {
  dynamic _convertNode(dynamic v) {
    if (v is YamlMap) {
      return v.toMap();
    } else if (v is YamlList) {
      var list = <dynamic>[];
      for (dynamic e in v) {
        list.add(_convertNode(e));
      }
      return list;
    } else {
      return v;
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    nodes.forEach((k, v) {
      map[(k as YamlScalar).value.toString()] = _convertNode(v.value);
    });
    return map;
  }
}
