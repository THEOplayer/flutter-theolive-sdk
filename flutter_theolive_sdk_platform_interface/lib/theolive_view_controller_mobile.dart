import 'package:theolive_platform_interface/debug_helpers.dart';
import 'package:theolive_platform_interface/pigeon/theolive_api.g.dart';
import 'package:theolive_platform_interface/pigeon_multi_instance_wrapper.dart';
import 'package:theolive_platform_interface/theolive_event_listener.dart';
import 'package:theolive_platform_interface/theolive_playerconfig.dart';
import 'package:theolive_platform_interface/theolive_view_controller_interface.dart';

class THEOliveViewControllerMobile extends THEOliveViewController implements THEOliveFlutterAPI {
  late final int _id;
  late final PigeonMultiInstanceBinaryMessengerWrapper _pigeonMessenger;
  late final THEOliveNativeAPI _nativeAPI;
  THEOliveEventListener? _eventListener;

  THEOliveViewControllerMobile(int id) : super(id) {
    _id = id;
    _pigeonMessenger = PigeonMultiInstanceBinaryMessengerWrapper(suffix: 'id_$_id');
    _nativeAPI = THEOliveNativeAPI(binaryMessenger: _pigeonMessenger);
    THEOliveFlutterAPI.setup(this, binaryMessenger: _pigeonMessenger);
  }

  @override
  void setEventListener(THEOliveEventListener? eventListener) {
    _eventListener = eventListener;
  }

  @override
  void preloadChannels(List<String> list) {
    _nativeAPI.preloadChannels(list);
  }

  @override
  void loadChannel(String channelId) {
    _nativeAPI.loadChannel(channelId).onError((error, stackTrace) =>
        //consume the exception, it is irrelevant to the flow, just for information
        dprint("ERROR during loadChannel: $error"));
  }

  @override
  void play() {
    _nativeAPI.play();
  }

  @override
  void pause() {
    _nativeAPI.pause();
  }

  @override
  Future<bool> isAutoplay() {
    return _nativeAPI.isAutoplay();
  }

  @override
  void setMuted(bool muted) {
    _nativeAPI.setMuted(muted);
  }

  @override
  void setBadNetworkMode(bool badNetworkMode) {
    _nativeAPI.setBadNetworkMode(badNetworkMode);
  }

  @override
  void goLive() {
    _nativeAPI.goLive();
  }

  @override
  void reset() {
    _nativeAPI.reset();
  }

  @override
  void updateNativePlayerConfiguration(NativePlayerConfiguration configuration) {
    final nativeConfig = PigeonNativePlayerConfiguration(sessionId: configuration.sessionId);
    _nativeAPI.updateConfiguration(nativeConfig);
  }

  @override
  void dispose() {
    _nativeAPI.dispose();
  }

  @override
  void onLifecycleResume() {
    _nativeAPI.onLifecycleResume();
  }

  @override
  void onLifecyclePause() {
    _nativeAPI.onLifecyclePause();
  }

  @override
  void onChannelLoadStart(String channelID) {
    _eventListener?.onChannelLoadStart(channelID);
  }

  @override
  void onChannelLoaded(String channelID) {
    _eventListener?.onChannelLoaded(channelID);
  }

  @override
  void onChannelOffline(String channelID) {
    _eventListener?.onChannelOffline(channelID);
  }

  @override
  void onWaiting() {
    _eventListener?.onWaiting();
  }

  @override
  void onPlay() {
    _eventListener?.onPlay();
  }

  @override
  void onPlaying() {
    _eventListener?.onPlaying();
  }

  @override
  void onPause() {
    _eventListener?.onPause();
  }

  @override
  void onMutedChange() {
    _eventListener?.onMutedChange();
  }

  @override
  void onIntentToFallback() {
    _eventListener?.onIntentToFallback();
  }

  @override
  void onEnterBadNetworkMode() {
    _eventListener?.onEnterBadNetworkMode();
  }

  @override
  void onExitBadNetworkMode() {
    _eventListener?.onExitBadNetworkMode();
  }

  @override
  void onReset() {
    _eventListener?.onReset();
  }

  @override
  void onError(String message) {
    _eventListener?.onError(message);
  }

}
