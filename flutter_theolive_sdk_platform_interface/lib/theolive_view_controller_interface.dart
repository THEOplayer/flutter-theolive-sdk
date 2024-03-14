import 'package:theolive_platform_interface/theolive_playerconfig.dart';

abstract class THEOliveViewController {
  THEOliveViewController(int id) {}

  void preloadChannels(List<String> list);

  void loadChannel(String channelId);

  void play();

  void pause();

  Future<bool> isAutoplay();

  void setMuted(bool muted);

  void setBadNetworkMode(bool badNetworkMode);

  void goLive();

  void updateNativePlayerConfiguration(NativePlayerConfiguration configuration);

  void reset();

  void manualDispose();

  void onLifecycleResume();

  void onLifecyclePause();
}

abstract class THEOliveViewControllerEventListener {
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
