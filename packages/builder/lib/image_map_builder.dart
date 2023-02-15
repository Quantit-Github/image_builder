import 'dart:io';

import 'package:build/build.dart';
import 'package:image_map_builder/src/generator.dart';

Builder build(BuilderOptions options) => ImageGenBuilder();

class ImageGenBuilder extends Builder {
  final generator = FlutterGenerator(File('pubspec.yaml'));
  // late final _config = loadPubspecConfigOrNull(generator.pubspecFile);
  // _FlutterGenBuilderState? _currentState;

  @override
  Future<void> build(BuildStep buildStep) async {
    // if (_config == null) return;
    // final state = await _createState(_config!, buildStep);
    // if (state.shouldSkipGenerate(_currentState)) return;
    // _currentState = state;

    await generator.build(
        // writer: (contents, path) {
        //   buildStep.writeAsString(_output(buildStep, path), contents);
        // },
        );
  }

  @override
  Map<String, List<String>> get buildExtensions {
    // if (_config == null) return {};
    // final output = _config!.pubspec.flutterGen.output;
    return {
      r'$package$': ["lib/gen/icon.map.dart"],
    };
  }

  // Future<_FlutterGenBuilderState> _createState(
  //     Config config, BuildStep buildStep) async {
  //   final pubspec = config.pubspec;

  //   final HashSet<String> assets = HashSet();
  //   if (pubspec.flutterGen.assets.enabled) {
  //     for (var assetInput in pubspec.flutter.assets) {
  //       if (assetInput.isEmpty) continue;
  //       if (assetInput.endsWith("/")) assetInput += "*";
  //       await for (var assetId in buildStep.findAssets(Glob(assetInput))) {
  //         assets.add(assetId.path);
  //       }
  //     }
  //   }

  //   final HashMap<String, Digest> colors = HashMap();
  //   if (pubspec.flutterGen.colors.enabled) {
  //     for (var colorInput in pubspec.flutterGen.colors.inputs) {
  //       if (colorInput.isEmpty) continue;
  //       await for (var assetId in buildStep.findAssets(Glob(colorInput))) {
  //         final digest = await buildStep.digest(assetId);
  //         colors[assetId.path] = digest;
  //       }
  //     }
  //   }

  //   final pubspecAsset =
  //       await buildStep.findAssets(Glob(config.pubspecFile.path)).single;

  //   final pubspecDigest = await buildStep.digest(pubspecAsset);

  //   return _FlutterGenBuilderState(
  //     pubspecDigest: pubspecDigest,
  //     assets: assets,
  //     colors: colors,
  //   );
  // }
}

// class _FlutterGenBuilderState {
//   final Digest pubspecDigest;
//   final HashSet<String> assets;
//   final HashMap<String, Digest> colors;

//   _FlutterGenBuilderState({
//     required this.pubspecDigest,
//     required this.assets,
//     required this.colors,
//   });

//   bool shouldSkipGenerate(_FlutterGenBuilderState? previous) {
//     if (previous == null) return false;
//     return pubspecDigest == previous.pubspecDigest &&
//         const SetEquality().equals(assets, previous.assets) &&
//         const MapEquality().equals(colors, previous.colors);
//   }
// }
