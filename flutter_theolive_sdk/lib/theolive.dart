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

  /// Whether the player is loaded.
  bool isLoaded() {
    return _playerState.isLoaded;
  }

  /// Whether the player is paused.
  bool isPaused() {
    return _playerState.isPaused;
  }

  void updateNativePlayerConfiguration(NativePlayerConfiguration configuration) {
    _viewController.updateNativePlayerConfiguration(configuration);
  }

  void preloadChannels(List<String> list) {
    _viewController.preloadChannels(list);
  }

  void loadChannel(String channelId) {
    _viewController.loadChannel(channelId);
  }

  void play() {
    _viewController.play();
  }

  void pause() {
    _viewController.pause();
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
