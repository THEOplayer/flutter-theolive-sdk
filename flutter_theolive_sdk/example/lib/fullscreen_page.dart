import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_theolive_example/debug_tools.dart';
import 'package:flutter_theolive_example/movie_page.dart';
import 'package:theolive/theolive.dart';

class FullscreenPage extends StatefulWidget {
  final THEOlive theoLive;

  const FullscreenPage({super.key, required this.theoLive});

  @override
  State<FullscreenPage> createState() => _FullscreenPageState();
}

class _FullscreenPageState extends State<FullscreenPage> with THEOliveEventListener {
  bool willPop = false;
  bool _isPaused = false;

  @override
  void initState() {
    dprint("_FullscreenPageState with THEOliveView: initState ");
    super.initState();

    widget.theoLive.addEventListener(this);
    _updateLocalPausedState();
  }

  void _updateLocalPausedState() {
    _isPaused = widget.theoLive.isPaused();
  }

  @override
  void dispose() {
    dprint("_FullscreenPageState with THEOliveView: dispose ");
    widget.theoLive.removeEventListener(this);
    super.dispose();
  }

  void _playPause() {
    if (widget.theoLive.isPaused()) {
      widget.theoLive.play();
    } else {
      widget.theoLive.pause();
    }
  }

  @override
  void onPlay() {
    setState(() {
      _updateLocalPausedState();
    });
  }

  @override
  void onPause() {
    setState(() {
      _updateLocalPausedState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomWillPopScope(
      onWillPop: () async {
        dprint("_FullscreenPageState with THEOliveView: onWillPop ");
        setState(() {
          willPop = true;
        });
        return true;
      },
      child: Scaffold(
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            //check orientation variable to identify the current mode
            //double w = MediaQuery.of(context).size.width;
            //double h = MediaQuery.of(context).size.height;
            //bool landscape = false;
            return Center(child: !willPop ? ChromelessPlayer(key: ChromelessPlayer.globalKey, player: widget.theoLive) : Container());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _playPause,
          tooltip: 'Load',
          child: _isPaused ? const Icon(Icons.play_arrow) : const Icon(Icons.pause),
        ),
      ),
    );
  }
}

// Custom WillPopScope, because the original WillPopScope breaks the back navigation on iOS
class CustomWillPopScope extends StatelessWidget {
  const CustomWillPopScope({required this.child, required this.onWillPop, Key? key}) : super(key: key);

  final Widget child;
  final WillPopCallback onWillPop;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? GestureDetector(
            onPanUpdate: (details) async {
              if (details.delta.dx > 0) {
                if (await onWillPop()) {
                  Navigator.of(context).pop();
                }
              }
            },
            child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: child,
            ))
        : WillPopScope(onWillPop: onWillPop, child: child);
  }
}
