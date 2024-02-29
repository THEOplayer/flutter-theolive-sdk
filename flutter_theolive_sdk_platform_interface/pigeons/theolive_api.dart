import 'package:pigeon/pigeon.dart';

//run in the root folder: flutter pub run pigeon --input pigeons/theolive_api.dart

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeon/theolive_api.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: '../flutter_theolive_sdk_android/android/src/main/kotlin/live/theo/sdk/flutter_theolive/pigeon/THEOliveAPI.g.kt',
  kotlinOptions: KotlinOptions(
    package: 'live.theo.sdk.flutter_theolive.pigeon'
  ),
  swiftOut: '../flutter_theolive_sdk_ios/ios/Classes/pigeon/THEOliveAPI.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'flutter_theolive',
))


//Talking to the native
@HostApi()
abstract class THEOliveNativeAPI {

  void loadChannel(String channelID);
  void preloadChannels(List<String> channelIDs);
  void play();
  void pause();
  void goLive();

  // Update the config of the player, make sure to call this before loading a channel.
  void updateConfiguration(PigeonNativePlayerConfiguration configuration);

  // helper APIs
  void manualDispose();

  // application lifecycle listeners
  void onLifecycleResume();
  void onLifecyclePause();

}

//Native talks to Dart

@FlutterApi()
abstract class THEOliveFlutterAPI {
  void onChannelLoadedEvent(String channelID);
  void onChannelLoadStartEvent(String channelID);
  void onChannelOfflineEvent(String channelID);
  void onPlaying();
  void onWaiting();
  void onPause();
  void onPlay();
  void onIntentToFallback();
  void onReset();
  void onError(String message);
}

class PigeonNativePlayerConfiguration {
  String? sessionId;
}