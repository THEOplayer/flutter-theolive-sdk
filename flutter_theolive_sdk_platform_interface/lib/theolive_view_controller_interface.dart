import 'package:theolive_platform_interface/theolive_event_listener.dart';
import 'package:theolive_platform_interface/theolive_playerconfig.dart';

abstract class THEOliveViewController {
  THEOliveViewController(int id) {}

  void setEventListener(THEOliveEventListener? eventListener);

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

  void dispose();

  void onLifecycleResume();

  void onLifecyclePause();
}
