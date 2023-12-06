import 'package:pigeon/pigeon.dart';

//run in the root folder: flutter pub run pigeon --input pigeons/theolive_api.dart

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

  @async
  void loadChannel(String channelID);

  void play();

  void pause();

  void manualDispose();

  void preloadChannels(List<String> channelIDs);
}

//Native talks to Dart

@FlutterApi()
abstract class THEOliveFlutterAPI {
  void onChannelLoadedEvent(String channelID);
  void onPlaying();
}

