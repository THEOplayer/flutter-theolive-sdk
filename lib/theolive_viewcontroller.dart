import 'package:flutter_theolive/debug_helpers.dart';
import 'package:flutter_theolive/pigeon/theolive_api.g.dart';
import 'package:flutter_theolive/pigeon_multi_instance_wrapper.dart';

class THEOliveViewController implements  THEOliveFlutterAPI{
  static const String _TAG = "FL_DART_THEOliveViewController";

  final int _id;
  THEOliveViewControllerEventListener? eventListener;

  late final THEOliveNativeAPI _nativeAPI;
  late final PigeonMultiInstanceBinaryMessengerWrapper _pigeonMessenger;

  THEOliveViewController(this._id) {
    _pigeonMessenger = PigeonMultiInstanceBinaryMessengerWrapper(suffix: 'id_$_id');
    _nativeAPI = THEOliveNativeAPI(binaryMessenger: _pigeonMessenger);
    THEOliveFlutterAPI.setup(this, binaryMessenger: _pigeonMessenger);
  }

  void loadChannel(String channelId) {
    _nativeAPI.loadChannel(channelId).onError(
      //consume the exception, it is irrelevant to the flow, just for information
            (error, stackTrace) => dprint("ERROR during loadChannel: $error")
    );
  }

  void play() {
    _nativeAPI.play();
  }

  void pause() {
    _nativeAPI.pause();
  }

  void manualDispose() {
    _nativeAPI.manualDispose();
  }

  @override
  void onChannelLoadedEvent(String channelID) {
    dprint("$_TAG  onChannelLoaded received: $channelID");
    eventListener?.onChannelLoadedEvent(channelID);
  }

  @override
  void onPlaying() {
    dprint("$_TAG  onPlaying received");
    eventListener?.onPlaying();
  }

  void preloadChannels(List<String> list) {
    _nativeAPI.preloadChannels(list);
  }

  @override
  void onChannelLoadStartEvent(String channelID) {
    dprint("$_TAG  onChannelLoadStart received: $channelID");
    eventListener?.onChannelLoadStartEvent(channelID);
  }

  @override
  void onChannelOfflineEvent(String channelID) {
    dprint("$_TAG  onChannelOfflineEvent received: $channelID");
    eventListener?.onChannelOfflineEvent(channelID);
  }

  @override
  void onError(String message) {
    dprint("$_TAG  onError received: $message");
    eventListener?.onError(message);
  }

  @override
  void onIntentToFallback() {
    dprint("$_TAG  onIntentToFallback received");
    eventListener?.onIntentToFallback();
  }

  @override
  void onPause() {
    dprint("$_TAG  onPause received");
    eventListener?.onPause();
  }

  @override
  void onPlay() {
    dprint("$_TAG  onPlay received");
    eventListener?.onPlay();
  }

  @override
  void onReset() {
    dprint("$_TAG  onReset received");
    eventListener?.onReset();
  }

  @override
  void onWaiting() {
    dprint("$_TAG  onWaiting received");
    eventListener?.onWaiting();
  }
}

abstract class THEOliveViewControllerEventListener {
  void onChannelLoadedEvent(String channelID);
  void onChannelLoadStartEvent(String channelID);
  void onChannelOfflineEvent(String channelID);
  void onIntentToFallback();
  void onError(String message);

  void onPlaying();
  void onPause();
  void onPlay();
  void onReset();
  void onWaiting();
}