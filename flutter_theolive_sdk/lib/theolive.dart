import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:theolive/theolive_view.dart';
import 'package:theolive_platform_interface/debug_helpers.dart';
import 'package:theolive_platform_interface/theolive_playerconfig.dart';
import 'package:theolive_platform_interface/theolive_view_controller_interface.dart';

export 'package:theolive/theolive_view.dart';
export 'package:theolive_platform_interface/theolive_playerconfig.dart';
export 'package:theolive_platform_interface/theolive_view_controller_interface.dart';
export 'package:theolive_platform_interface/theolive_viewcontroller_mobile.dart';

typedef PlayerCreatedCallback = void Function();

class THEOlive {
  final PlayerConfig playerConfig;
  final PlayerCreatedCallback? onCreate;
  late THEOliveViewController viewController;

  late final THEOliveView _tlv;
  late AppLifecycleListener _lifecycleListener;

  THEOlive({required this.playerConfig, this.onCreate}) {
    _tlv = THEOliveView(
        key: GlobalKey(debugLabel: "playerUniqueKey"),
        playerConfig: playerConfig,
        onTHEOliveViewCreated: (THEOliveViewController viewController) {
          this.viewController = viewController;
          setupLifeCycleListeners();
          onCreate?.call();
        });
  }

  void setupLifeCycleListeners() {
    _lifecycleListener = AppLifecycleListener(
      onResume: () {
        viewController.onLifecycleResume();
      },
      onPause: () {
        viewController.onLifecyclePause();
      },
      onStateChange: (state) {
        dprint("_THEOliveViewState lifecycle change: $state");
      });
  }

  /// Returns the player widget that can be added to the view hierarchy to show videos
  Widget getView() {
    return _tlv;
  }

  void dispose() {
    dprint("_THEOliveViewState dispose");

    _lifecycleListener.dispose();
    // NOTE: this would be nicer, if we move it inside the THEOliveView that's a StatefulWidget
    // FIX for https://github.com/flutter/flutter/issues/97499
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      viewController.manualDispose();
    }
  }
}
