import 'package:pigeon/pigeon.dart';

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
