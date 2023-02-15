import 'dart:io';
import 'package:image_map_core/src/config.dart';

class FlutterGenerator {
  const FlutterGenerator({required this.config});
  final Config config;

  factory FlutterGenerator.fromFile(File pubspecFile) {
    return FlutterGenerator(config: Config.fromFile(pubspecFile));
  }

  Future<void> build() async {
    stdout.writeln(config.pubspec.toJson().toString());
    stdout.writeln(config.pubspec.imageMapGen.outputFilePathList.toString());
    // config ??= loadPubspecConfigOrNull(pubspecFile);
    // if (config == null) return;

    // final flutter = config.pubspec.flutter;
    // final flutterGen = config.pubspec.flutterGen;
    // final output = config.pubspec.flutterGen.output;
    // final lineLength = config.pubspec.flutterGen.lineLength;
    // final formatter = DartFormatter(pageWidth: lineLength, lineEnding: '\n');

    // void defaultWriter(String contents, String path) {
    //   final file = File(path);
    //   if (!file.existsSync()) {
    //     file.createSync(recursive: true);
    //   }
    //   file.writeAsStringSync(contents);
    // }

    // writer ??= defaultWriter;

    // final absoluteOutput =
    //     Directory(normalize(join(pubspecFile.parent.path, output)));
    // if (!absoluteOutput.existsSync()) {
    //   absoluteOutput.createSync(recursive: true);
    // }

    // if (flutterGen.colors.enabled && flutterGen.colors.inputs.isNotEmpty) {
    //   final generated =
    //       generateColors(pubspecFile, formatter, flutterGen.colors);
    //   final colorsPath =
    //       normalize(join(pubspecFile.parent.path, output, colorsName));
    //   writer(generated, colorsPath);
    //   stdout.writeln('Generated: $colorsPath');
    // }

    // if (flutterGen.assets.enabled && flutter.assets.isNotEmpty) {
    //   final generated = generateAssets(
    //     AssetsGenConfig.fromConfig(pubspecFile, config),
    //     formatter,
    //   );
    //   final assetsPath =
    //       normalize(join(pubspecFile.parent.path, output, assetsName));
    //   writer(generated, assetsPath);
    //   stdout.writeln('Generated: $assetsPath');
    // }

    // if (flutterGen.fonts.enabled && flutter.fonts.isNotEmpty) {
    //   final generated =
    //       generateFonts(formatter, flutter.fonts, flutterGen.fonts);
    //   final fontsPath =
    //       normalize(join(pubspecFile.parent.path, output, fontsName));
    //   writer(generated, fontsPath);
    //   stdout.writeln('Generated: $fontsPath');
    // }

    stdout.writeln('ImageMapBuilder finished.');
  }
}
