import 'package:pigeon/pigeon.dart';

import '../models/player.dart';

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
