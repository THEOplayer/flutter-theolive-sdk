import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:theolive_ios/theolive_viewcontroller_ios.dart';
import 'package:theolive_platform_interface/theolive_platform_interface.dart';
import 'package:theolive_platform_interface/theolive_playerconfig.dart';
import 'package:theolive_platform_interface/debug_helpers.dart';

class THEOliveIOS extends TheolivePlatform {
  /// Registers this class as the default instance of [TheoplayerPlatform].
  static void registerWith() {
    TheolivePlatform.instance = THEOliveIOS();
  }

  @override
  Widget buildView(BuildContext context, PlayerConfig playerConfig, THEOliveViewCreatedCallback createdCallback) {
    // This is used in the platform side to register the view.
    const String viewType = 'theoliveview';
    // Pass parameters to the platform side.
    Map<String, dynamic> creationParams = <String, dynamic>{};

    return UiKitView(
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: (id) {
          dprint("_THEOliveViewState OnPlatformViewCreatedListener");
          createdCallback(THEOliveViewControllerIOS(id));
        });
  }
}