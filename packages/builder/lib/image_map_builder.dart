import 'dart:io';

import 'package:build/build.dart';
import 'package:image_map_core/image_map_core.dart';

Builder build(BuilderOptions options) => ImageGenBuilder();

class ImageGenBuilder extends Builder {
  final generator = FlutterGenerator.fromFile(File('pubspec.yaml'));

  static AssetId _output(BuildStep buildStep, String path) {
    return AssetId(
      buildStep.inputId.package,
      path,
    );
  }

  @override
  Future<void> build(BuildStep buildStep) async {
    if (generator.config.checkSetAssets) {
      return;
    }

    await generator.build(
      writer: (contents, path) {
        buildStep.writeAsString(_output(buildStep, path), contents);
      },
    );
  }

  @override
  Map<String, List<String>> get buildExtensions {
    return {
      r'$package$': generator.config.pubspec.imageMapGen.outputFilePathList,
    };
  }
}
