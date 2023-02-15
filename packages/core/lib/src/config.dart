import 'dart:io';

import 'package:image_map_core/src/model/pubspec.dart';
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
