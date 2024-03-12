import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:theolive/theolive_state.dart';
import 'package:theolive/theolive_view.dart';
import 'package:theolive_platform_interface/debug_helpers.dart';
import 'package:theolive_platform_interface/theolive_playerconfig.dart';
import 'package:theolive_platform_interface/theolive_view_controller_interface.dart';

export 'package:theolive/theolive_view.dart';
export 'package:theolive_platform_interface/theolive_playerconfig.dart';
export 'package:theolive_platform_interface/theolive_view_controller_interface.dart';
export 'package:theolive_platform_interface/theolive_view_controller_mobile.dart';

typedef PlayerCreatedCallback = void Function();
typedef StateChangeListener = void Function();

class THEOlive {
  final PlayerConfig playerConfig;
  final PlayerCreatedCallback? onCreate;
  late final PlayerState _playerState;
  late THEOliveViewController _viewController;

  late final THEOliveView _tlv;
  late AppLifecycleListener _lifecycleListener;

  THEOlive({required this.playerConfig, this.onCreate}) {
    _playerState = PlayerState();
    _tlv = THEOliveView(
        key: UniqueKey(),
        playerConfig: playerConfig,
        onTHEOliveViewCreated: (THEOliveViewController viewController) {
          _viewController = viewController;
          _playerState.setViewController(viewController);
          setupLifeCycleListeners();
          onCreate?.call();
          _playerState.initialized();
        });
  }

  void setupLifeCycleListeners() {
    _lifecycleListener = AppLifecycleListener(
      onResume: () {
        _viewController.onLifecycleResume();
      },
      onPause: () {
        _viewController.onLifecyclePause();
      },
      onStateChange: (state) {
        dprint("_THEOliveViewState lifecycle change: $state");
      });
  }

  /// Returns the player widget that can be added to the view hierarchy to show videos
  Widget getView() {
    return _tlv;
  }

  void setStateListener(StateChangeListener listener) {
    _playerState.setStateListener(listener);
  }

  /// Update the config of the player, make sure to call this before loading a channel.
  void updateNativePlayerConfiguration(NativePlayerConfiguration configuration) {
    _viewController.updateNativePlayerConfiguration(configuration);
  }

  /// Preload some channels to allow faster switching between channels. This will retrieve the metadata of all the
  /// given channel ids and store it so next loadChannel calls are faster.
  void preloadChannels(List<String> list) {
    _viewController.preloadChannels(list);
  }

  /// Load a channel.
  void loadChannel(String channelId) {
    _viewController.loadChannel(channelId);
  }

  /// Start or resume playback.
  void play() {
    _viewController.play();
  }

  /// Pause playback.
  void pause() {
    _viewController.pause();
  }

  /// Seek to the live edge.
  void goLive() {
    _viewController.goLive();
  }

  /// Whether the player is loaded.
  bool isLoaded() {
    return _playerState.isLoaded;
  }

  /// Whether the player is paused.
  bool isPaused() {
    return _playerState.isPaused;
  }

  /// Whether the currently loaded channel has autoplay enabled.
  bool isAutoplay() {
    return _playerState.isAutoplay;
  }

  /// Set whether audio is muted.
  void setMuted(bool muted) {
    _playerState.muted = muted;
    _viewController.setMuted(muted);
  }

  /// Whether audio is muted.
  bool isMuted() {
    return _playerState.muted;
  }

  /// Set whether the player is in bad network mode.
  ///
  /// ABR functionality works best on qualities with a bitrate of 800Kbit/s or more. So by default the player filters
  /// out qualities with a lower bandwidth as it has difficulty upswitching from those qualities. However, when the
  /// player detects that the stream really isn't playable on the 800Kbit/s+ qualities, it enters bad network mode.
  /// In this mode, the player will also select lower bitrate qualities with the risk of never upswitching. It might
  /// still upswitch, but we can't give any guarantees. This mode can be exited by setting badNetworkMode to false.
  void setBadNetworkMode(bool badNetworkMode) {
    _viewController.setBadNetworkMode(badNetworkMode);
  }

  /// Whether the player is in bad network mode.
  ///
  /// ABR functionality works best on qualities with a bitrate of 800Kbit/s or more. So by default the player filters
  /// out qualities with a lower bandwidth as it has difficulty upswitching from those qualities. However, when the
  /// player detects that the stream really isn't playable on the 800Kbit/s+ qualities, it enters bad network mode.
  /// In this mode, the player will also select lower bitrate qualities with the risk of never upswitching. It might
  /// still upswitch, but we can't give any guarantees. This mode can be exited by setting badNetworkMode to false.
  bool isBadNetworkMode() {
    return _playerState.badNetworkMode;
  }

  /// Add a header provider which allows adding headers to the requests the player makes.
  void addHeaderProvider(HeaderProvider headerProvider) {
    _viewController.addHeaderProvider(headerProvider);
  }

  /// Remove a previously added header provider.
  void removeHeaderProvider(HeaderProvider headerProvider) {
    _viewController.removeHeaderProvider(headerProvider);
  }

  /// Resets the player.
  /// This will stop playback and reset the state.
  /// But unlike destroy, can be followed up with a new loadChannel call.
  void reset() {
    _viewController.reset();
  }

  void manualDispose() {
    _viewController.manualDispose();
  }

  void dispose() {
    dprint("_THEOliveViewState dispose");

    _lifecycleListener.dispose();
    // NOTE: this would be nicer, if we move it inside the THEOliveView that's a StatefulWidget
    // FIX for https://github.com/flutter/flutter/issues/97499
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      _viewController.manualDispose();
    }
  }
}
