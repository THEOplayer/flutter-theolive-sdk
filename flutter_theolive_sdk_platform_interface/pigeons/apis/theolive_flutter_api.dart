import 'package:pigeon/pigeon.dart';

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
