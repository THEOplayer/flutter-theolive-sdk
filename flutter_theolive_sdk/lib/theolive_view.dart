import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return TheolivePlatform.instance.buildView(context, widget.playerConfig, widget.onTHEOliveViewCreated);
  }
}
