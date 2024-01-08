import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_theolive/debug_helpers.dart';
import 'package:flutter_theolive/theolive_playerconfig.dart';
import 'package:flutter_theolive/theolive_viewcontroller.dart';

class THEOliveView extends StatefulWidget {

  final Function(THEOliveViewController) onTHEOliveViewCreated;
  late final PlayerConfig _playerConfig;

  THEOliveView({required Key key, required this.onTHEOliveViewCreated, playerConfig}) : super(key: key) {
    _playerConfig = playerConfig ?? PlayerConfig(AndroidConfig());
  }

  late THEOliveViewController viewController;

  @override
  State<StatefulWidget> createState() {
    return _THEOliveViewState();
  }

}

class _THEOliveViewState extends State<THEOliveView> {

  late THEOliveViewController viewController;

  @override
  void initState() {
    dprint("_THEOliveViewState initState");
    super.initState();
  }

  @override
  void dispose() {
    dprint("_THEOliveViewState dispose");
    // NOTE: this would be nicer, if we move it inside the THEOliveView that's a StatefulWidget
    // FIX for https://github.com/flutter/flutter/issues/97499
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      viewController.manualDispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dprint("_THEOliveViewState build");

    // This is used in the platform side to register the view.
    const String viewType = 'theoliveview';
    // Pass parameters to the platform side.
    Map<String, dynamic> creationParams = <String, dynamic>{};

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:

        //TODO: use single object
        creationParams["nativeRenderingTarget"] = widget._playerConfig.androidConfig.nativeRenderingTarget.name;
        creationParams["useHybridComposition"] = widget._playerConfig.androidConfig.useHybridComposition;

        return PlatformViewLink(
          viewType: viewType,
          surfaceFactory:
              (context, controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{
              },
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (params) {
            late AndroidViewController androidViewController;

            if (widget._playerConfig.androidConfig.useHybridComposition) {
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

            return androidViewController..addOnPlatformViewCreatedListener((id) {
                dprint("_THEOliveViewState OnPlatformViewCreatedListener");
                params.onPlatformViewCreated(id);
                viewController = THEOliveViewController(id);
                widget.viewController = viewController;
                widget.onTHEOliveViewCreated(viewController);
              })
              ..create();
          },
        );
      case TargetPlatform.iOS:
        return UiKitView(
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            onPlatformViewCreated: (id) {
              dprint("_THEOliveViewState OnPlatformViewCreatedListener");
              viewController = THEOliveViewController(id);
              widget.viewController = viewController;
              widget.onTHEOliveViewCreated(viewController);
            }
        );
      default:
        return Text("Unsupported platform $defaultTargetPlatform");
    }
  }

  @override
  void didChangeDependencies() {
    dprint("_THEOliveViewState didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void activate() {
    dprint("_THEOliveViewState activate");
    super.activate();
  }

  @override
  void deactivate() {
    dprint("_THEOliveViewState deactivate");
    super.deactivate();
  }

  @override
  void reassemble() {
    dprint("_THEOliveViewState reassemble");
    super.reassemble();
  }
}