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

  void preloadChannels(List<String> channelIDs);

  void loadChannel(String channelID);

  void play();

  void pause();

  bool isAutoplay();

  void setMuted(bool muted);

  void setBadNetworkMode(bool badNetworkMode);

  void goLive();

  // void addHeaderProvider(dynamic headerProvider);

  // void removeHeaderProvider(dynamic headerProvider);

  void reset();

  void updateConfiguration(PigeonNativePlayerConfiguration configuration);

  void manualDispose();

  void onLifecycleResume();

  void onLifecyclePause();
}



//Talking from Native to Dart
@FlutterApi()
abstract class THEOliveFlutterAPI {
  void onChannelLoadStart(String channelID);

  void onChannelLoaded(String channelID);

  void onChannelOffline(String channelID);

  void onWaiting();

  void onPlay();

  void onPlaying();

  void onPause();

  void onMutedChange();

  void onIntentToFallback();

  void onEnterBadNetworkMode();

  void onExitBadNetworkMode();

  void onReset();

  void onError(String message);

}

