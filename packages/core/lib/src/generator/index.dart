import 'dart:io';
import 'package:dart_style/dart_style.dart';
import 'package:image_map_core/src/config.dart';
import 'package:image_map_core/src/model/image_map_gen.dart';
import 'package:image_map_core/src/utils.dart';
import 'package:path/path.dart';

class FlutterGenerator {
  const FlutterGenerator({required this.config});
  final Config config;

  factory FlutterGenerator.fromFile(File pubspecFile) {
    return FlutterGenerator(config: Config.fromFile(pubspecFile));
  }

  void defaultWriter(String contents, String path) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file.writeAsStringSync(contents);
  }

  Future<void> build({FileWriter? writer}) async {
    if (config.checkSetAssets) {
      return;
    }

    final imageMapGen = config.pubspec.imageMapGen;
    final lineLength = config.pubspec.flutterGen.lineLength;
    final formatter = DartFormatter(pageWidth: lineLength, lineEnding: '\n');

    final absoluteOutput = Directory(config.imageGenOutputPath);
    if (!absoluteOutput.existsSync()) {
      absoluteOutput.createSync(recursive: true);
    }

    writer ??= defaultWriter;

    if (!checkFlutterGenAssetsFileExist) {
      stdout.writeln("Error: flutter_gen이 먼저 선행해서 build 되어야 합니다.");
      return;
    }

    for (ImageGenMapFile mapFile in imageMapGen.mapFiles) {
      generateMap(mapFile, formatter, writer);
    }

    stdout.writeln('ImageMapBuilder finished.');
  }

  bool get checkFlutterGenAssetsFileExist =>
      File(config.flutterGenAssetsFilePath).existsSync();

  void generateMap(
      ImageGenMapFile file, DartFormatter formatter, FileWriter writer) {
    final String assetsPath =
        normalize(join(config.imageGenOutputPath, file.fileName));
    final generated = file.classOutput(
      formatter,
      config.generateStringBuffer(),
    );
    writer(generated, assetsPath);
    stdout.writeln('Generated: $assetsPath');
  }
}
