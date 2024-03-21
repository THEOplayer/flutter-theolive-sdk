import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:theolive_android/theolive_viewcontroller_android.dart';
import 'package:theolive_platform_interface/theolive_platform_interface.dart';
import 'package:theolive_platform_interface/theolive_playerconfig.dart';
import 'package:theolive_platform_interface/debug_helpers.dart';

class THEOliveAndroid extends TheolivePlatform {
  /// Registers this class as the default instance of [TheoplayerPlatform].
  static void registerWith() {
    TheolivePlatform.instance = THEOliveAndroid();
  }

  @override
  Widget buildView(BuildContext context, PlayerConfig playerConfig, THEOliveViewCreatedCallback createdCallback) {
    // This is used in the platform side to register the view.
    const String viewType = 'theoliveview';
    // Pass parameters to the platform side.
    Map<String, dynamic> creationParams = <String, dynamic>{};

    //TODO: use single object
    creationParams["nativeRenderingTarget"] = playerConfig.androidConfig.nativeRenderingTarget.name;
    creationParams["useHybridComposition"] = playerConfig.androidConfig.useHybridComposition;

    return PlatformViewLink(
      viewType: viewType,
      surfaceFactory: (context, controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (params) {
        late AndroidViewController androidViewController;

        if (playerConfig.androidConfig.useHybridComposition) {
          androidViewController = PlatformViewsService.initExpensiveAndroidView(
            id: params.id,
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            onFocus: () {
              params.onFocusChanged(true);
            },
          );
        } else {
          androidViewController = PlatformViewsService.initAndroidView(
            id: params.id,
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            onFocus: () {
              params.onFocusChanged(true);
            },
          );
        }

        return androidViewController
          ..addOnPlatformViewCreatedListener((id) {
            dprint("THEOliveAndroid OnPlatformViewCreatedListener");
            params.onPlatformViewCreated(id);
            createdCallback(THEOliveViewControllerAndroid(id));
          })
          ..create();
      },
    );
  }
}
