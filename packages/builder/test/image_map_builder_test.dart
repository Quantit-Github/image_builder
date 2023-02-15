import 'dart:io';

import 'package:image_map_core/image_map_core.dart';

void main() {
  final generator = FlutterGenerator.fromFile(File('test/pubspec_test.yaml'));
  generator.build();
}
