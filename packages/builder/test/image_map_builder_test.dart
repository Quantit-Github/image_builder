import 'dart:io';

import 'package:image_map_builder/src/generator.dart';

void main() {
  final generator = FlutterGenerator(File('test/pubspec_test.yaml'));
  generator.build();
}
