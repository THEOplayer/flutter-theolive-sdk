import 'package:pigeon/pigeon.dart';


@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeon/theolive_api.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/live/theo/sdk/flutter_theolive/pigeon/THEOliveAPI.g.kt',
  kotlinOptions: KotlinOptions(
    package: 'live.theo.sdk.flutter_theolive.pigeon'
  ),
  swiftOut: 'ios/Classes/pigeon/THEOliveAPI.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'flutter_theolive',
))


//Talking to the native
@HostApi()
abstract class THEOliveNativeAPI {
  void loadChannel(String channelID);
}

//Native talks to Dart
/*
@FlutterApi()
abstract class THEOliveFlutterAPI {
  void onChannelLoaded();
}
 */