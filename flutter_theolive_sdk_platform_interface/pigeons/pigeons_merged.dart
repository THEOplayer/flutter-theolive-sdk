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

class PigeonNativePlayerConfiguration {
  String? sessionId;
}




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



//Talking from Native to Dart
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

