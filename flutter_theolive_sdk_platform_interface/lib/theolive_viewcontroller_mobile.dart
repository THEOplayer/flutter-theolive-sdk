import 'package:theolive_platform_interface/debug_helpers.dart';
import 'package:theolive_platform_interface/pigeon/theolive_api.g.dart';
import 'package:theolive_platform_interface/pigeon_multi_instance_wrapper.dart';
import 'package:theolive_platform_interface/theolive_view_controller_interface.dart';

class THEOliveViewControllerMobile extends THEOliveViewController implements THEOliveFlutterAPI {
  static const String _debugTag = "FL_DART_THEOliveViewController";

  late final int _id;
  THEOliveViewControllerEventListener? eventListener;

  late final THEOliveNativeAPI _nativeAPI;
  late final PigeonMultiInstanceBinaryMessengerWrapper _pigeonMessenger;

  THEOliveViewControllerMobile(int id) : super(id) {
    this._id = id;
    _pigeonMessenger = PigeonMultiInstanceBinaryMessengerWrapper(suffix: 'id_$_id');
    _nativeAPI = THEOliveNativeAPI(binaryMessenger: _pigeonMessenger);
    THEOliveFlutterAPI.setup(this, binaryMessenger: _pigeonMessenger);
  }

  void loadChannel(String channelId) {
    _nativeAPI.loadChannel(channelId).onError(
        //consume the exception, it is irrelevant to the flow, just for information
        (error, stackTrace) => dprint("ERROR during loadChannel: $error"));
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

  //app lifecycle
  void onLifecycleResume() {
    _nativeAPI.onLifecycleResume();
  }

  void onLifecyclePause() {
    _nativeAPI.onLifecyclePause();
  }

  @override
  void onChannelLoadedEvent(String channelID) {
    dprint("$_debugTag  onChannelLoaded received: $channelID");
    eventListener?.onChannelLoadedEvent(channelID);
  }

  @override
  void onPlaying() {
    dprint("$_debugTag  onPlaying received");
    eventListener?.onPlaying();
  }

  void preloadChannels(List<String> list) {
    _nativeAPI.preloadChannels(list);
  }

  /// Updates the config of the player, make sure to call this before loading a channel.
  void updateNativePlayerConfiguration(NativePlayerConfiguration configuration) {
    final nativeConfig = PigeonNativePlayerConfiguration(sessionId: configuration.sessionId);
    _nativeAPI.updateConfiguration(nativeConfig);
  }

  @override
  void onChannelLoadStartEvent(String channelID) {
    dprint("$_debugTag  onChannelLoadStart received: $channelID");
    eventListener?.onChannelLoadStartEvent(channelID);
  }

  @override
  void onChannelOfflineEvent(String channelID) {
    dprint("$_debugTag  onChannelOfflineEvent received: $channelID");
    eventListener?.onChannelOfflineEvent(channelID);
  }

  @override
  void onError(String message) {
    dprint("$_debugTag  onError received: $message");
    eventListener?.onError(message);
  }

  @override
  void onIntentToFallback() {
    dprint("$_debugTag  onIntentToFallback received");
    eventListener?.onIntentToFallback();
  }

  @override
  void onPause() {
    dprint("$_debugTag  onPause received");
    eventListener?.onPause();
  }

  @override
  void onPlay() {
    dprint("$_debugTag  onPlay received");
    eventListener?.onPlay();
  }

  @override
  void onReset() {
    dprint("$_debugTag  onReset received");
    eventListener?.onReset();
  }

  @override
  void onWaiting() {
    dprint("$_debugTag  onWaiting received");
    eventListener?.onWaiting();
  }

}
