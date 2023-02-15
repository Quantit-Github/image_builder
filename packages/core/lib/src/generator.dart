import 'dart:io';
import 'package:image_map_core/src/config.dart';

class FlutterGenerator {
  const FlutterGenerator(this.pubspecFile);
  final File pubspecFile;

  Future<void> build() async {
    Config config = Config.fromFile(pubspecFile);
    // stdout.writeln(config.pubspec.toJson().toString());
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
