abstract class THEOliveViewController{
  static const String _debugTag = "FL_DART_THEOliveViewController";

  THEOliveViewController(int id) {}

  void loadChannel(String channelId);

  void play();

  void pause();

  void manualDispose();

  //app lifecycle
  void onLifecycleResume();

  void onLifecyclePause();

  void preloadChannels(List<String> list);

  /// Updates the config of the player, make sure to call this before loading a channel.
  void updateNativePlayerConfiguration(NativePlayerConfiguration configuration);

}

abstract class THEOliveViewControllerEventListener {
  void onChannelLoadedEvent(String channelID);

  void onChannelLoadStartEvent(String channelID);

  void onChannelOfflineEvent(String channelID);

  void onIntentToFallback();

  void onError(String message);

  void onPlaying();

  void onPause();

  void onPlay();

  void onReset();

  void onWaiting();
}

class NativePlayerConfiguration {
  String? sessionId;
}