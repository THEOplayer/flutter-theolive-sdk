import 'package:pigeon/pigeon.dart';

// run in the 'flutter_theolive_sdk_platform_interface' folder:
// dart run build_runner build --delete-conflicting-outputs

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeon/theolive_api.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: '../flutter_theolive_sdk_android/android/src/main/kotlin/com/theolive/flutter/pigeon/THEOliveAPI.g.kt',
  kotlinOptions: KotlinOptions(
    package: 'com.theolive.flutter.pigeon'
  ),
  swiftOut: '../flutter_theolive_sdk_ios/ios/Classes/pigeon/THEOliveAPI.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'flutter_theolive',
))
