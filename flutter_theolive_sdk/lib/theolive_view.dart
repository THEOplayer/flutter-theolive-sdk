import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theolive_platform_interface/theolive_platform_interface.dart';
import 'package:theolive_platform_interface/theolive_playerconfig.dart';
import 'package:theolive_platform_interface/debug_helpers.dart';
import 'package:theolive_platform_interface/theolive_view_controller_interface.dart';


//TODO: eliminate the need for this after refactoring
//ignore: must_be_immutable
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

  late AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    dprint("_THEOliveViewState initState");
    super.initState();
  }

  void setupLifeCycleListeners() {
    _lifecycleListener = AppLifecycleListener(
      onResume: (){
        viewController.onLifecycleResume();
      },
      onPause: () {
        viewController.onLifecyclePause();
      },
      onStateChange: (state) {
        dprint("_THEOliveViewState lifecycle change: $state");
      }
    );
  }

  @override
  void dispose() {
    dprint("_THEOliveViewState dispose");

    _lifecycleListener.dispose();
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

    return TheolivePlatform.instance.buildView(context, widget._playerConfig, (THEOliveViewController viewController) {
      this.viewController = viewController;
      setupLifeCycleListeners();
      widget.viewController = viewController;
      widget.onTHEOliveViewCreated(viewController);
    });
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
