import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:theolive/theolive_view.dart';
import 'package:theolive_platform_interface/debug_helpers.dart';
import 'package:theolive_platform_interface/theolive_playerconfig.dart';
import 'package:theolive_platform_interface/theolive_view_controller_interface.dart';
import 'package:theolive_platform_interface/theolive_viewcontroller_mobile.dart';

export 'package:theolive/theolive_view.dart';
export 'package:theolive_platform_interface/theolive_playerconfig.dart';
export 'package:theolive_platform_interface/theolive_view_controller_interface.dart';
export 'package:theolive_platform_interface/theolive_viewcontroller_mobile.dart';

typedef PlayerCreatedCallback = void Function();

class THEOlive implements THEOliveViewControllerEventListener {
  final PlayerConfig playerConfig;
  final PlayerCreatedCallback? onCreate;
  late THEOliveViewController _viewController;

  late final THEOliveView _tlv;
  late AppLifecycleListener _lifecycleListener;

  THEOlive({required this.playerConfig, this.onCreate}) {
    _tlv = THEOliveView(
        key: GlobalKey(debugLabel: "playerUniqueKey"),
        playerConfig: playerConfig,
        onTHEOliveViewCreated: (THEOliveViewController viewController) {
          _viewController = viewController;
          (_viewController as THEOliveViewControllerMobile).eventListener = this;
          setupLifeCycleListeners();
          onCreate?.call();
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

  void updateNativePlayerConfiguration(NativePlayerConfiguration configuration){
    _viewController.updateNativePlayerConfiguration(configuration);
  }

  void preloadChannels(List<String> list){
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

  void manualDispose(){
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

  @override
  void onChannelLoadStartEvent(String channelID) {
    // TODO: implement onChannelLoadStartEvent
  }

  @override
  void onChannelLoadedEvent(String channelID) {
    // TODO: implement onChannelLoadedEvent
  }

  @override
  void onChannelOfflineEvent(String channelID) {
    // TODO: implement onChannelOfflineEvent
  }

  @override
  void onError(String message) {
    // TODO: implement onError
  }

  @override
  void onIntentToFallback() {
    // TODO: implement onIntentToFallback
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onPlay() {
    // TODO: implement onPlay
  }

  @override
  void onPlaying() {
    // TODO: implement onPlaying
  }

  @override
  void onReset() {
    // TODO: implement onReset
  }

  @override
  void onWaiting() {
    // TODO: implement onWaiting
  }
}
