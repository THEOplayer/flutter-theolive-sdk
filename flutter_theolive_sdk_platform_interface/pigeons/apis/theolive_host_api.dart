import 'package:pigeon/pigeon.dart';

import '../models/player.dart';

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

  void dispose();

  void onLifecycleResume();

  void onLifecyclePause();
}
