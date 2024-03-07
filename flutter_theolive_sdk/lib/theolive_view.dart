import 'package:flutter/material.dart';
import 'package:theolive_platform_interface/debug_helpers.dart';
import 'package:theolive_platform_interface/theolive_platform_interface.dart';
import 'package:theolive_platform_interface/theolive_playerconfig.dart';
import 'package:theolive_platform_interface/theolive_view_controller_interface.dart';

class THEOliveView extends StatefulWidget {
  final PlayerConfig playerConfig;
  final Function(THEOliveViewController) onTHEOliveViewCreated;

  const THEOliveView({Key? key, required this.playerConfig, required this.onTHEOliveViewCreated}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _THEOliveViewState();
}

class _THEOliveViewState extends State<THEOliveView> {
  @override
  void initState() {
    dprint("_THEOliveViewState initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dprint("_THEOliveViewState build");

    return TheolivePlatform.instance.buildView(context, widget.playerConfig, widget.onTHEOliveViewCreated);
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

  @override
  void dispose() {
    dprint("_THEOliveViewState dispose");
    super.dispose();
  }
}
