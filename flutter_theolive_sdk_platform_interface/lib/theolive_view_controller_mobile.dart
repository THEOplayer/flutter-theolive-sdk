import 'package:theolive_platform_interface/helpers/theologger.dart';
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
    _nativeAPI.preloadChannels(list)
        .onError<Exception>((error, stackTrace) => exceptionHandler(exception: error, tag: "PIGEON", stacktrace: stackTrace));
  }

  @override
  void loadChannel(String channelId) {
    _nativeAPI.loadChannel(channelId)
        .onError<Exception>((error, stackTrace) => exceptionHandler(exception: error, tag: "PIGEON", stacktrace: stackTrace));
  }
    
  @override
  void play() {
    _nativeAPI.play()
        .onError<Exception>((error, stackTrace) => exceptionHandler(exception: error, tag: "PIGEON", stacktrace: stackTrace));
  }

  @override
  void pause() {
    _nativeAPI.pause()
        .onError<Exception>((error, stackTrace) => exceptionHandler(exception: error, tag: "PIGEON", stacktrace: stackTrace));
  }

  @override
  Future<bool> isAutoplay() {
    return _nativeAPI.isAutoplay()
        .onError<Exception>((error, stackTrace) {
          exceptionHandler(exception: error, tag: "PIGEON", stacktrace: stackTrace);
          return false;
        });
  }

  @override
  void setMuted(bool muted) {
    _nativeAPI.setMuted(muted)
        .onError<Exception>((error, stackTrace) => exceptionHandler(exception: error, tag: "PIGEON", stacktrace: stackTrace));
  }

  @override
  void setBadNetworkMode(bool badNetworkMode) {
    _nativeAPI.setBadNetworkMode(badNetworkMode)
        .onError<Exception>((error, stackTrace) => exceptionHandler(exception: error, tag: "PIGEON", stacktrace: stackTrace));
  }

  @override
  void goLive() {
    _nativeAPI.goLive()
        .onError<Exception>((error, stackTrace) => exceptionHandler(exception: error, tag: "PIGEON", stacktrace: stackTrace));
  }

  @override
  void reset() {
    _nativeAPI.reset()
        .onError<Exception>((error, stackTrace) => exceptionHandler(exception: error, tag: "PIGEON", stacktrace: stackTrace));
  }

  @override
  void updateNativePlayerConfiguration(NativePlayerConfiguration configuration) {
    final nativeConfig = PigeonNativePlayerConfiguration(sessionId: configuration.sessionId);
    _nativeAPI.updateConfiguration(nativeConfig)
        .onError<Exception>((error, stackTrace) => exceptionHandler(exception: error, tag: "PIGEON", stacktrace: stackTrace));
  }

  @override
  void dispose() {
    _nativeAPI.destroy()
        .onError<Exception>((error, stackTrace) => exceptionHandler(exception: error, tag: "PIGEON", stacktrace: stackTrace));
  }

  @override
  void onLifecycleResume() {
    _nativeAPI.onLifecycleResume()
        .onError<Exception>((error, stackTrace) => exceptionHandler(exception: error, tag: "PIGEON", stacktrace: stackTrace));
  }

  @override
  void onLifecyclePause() {
    _nativeAPI.onLifecyclePause()
        .onError<Exception>((error, stackTrace) => exceptionHandler(exception: error, tag: "PIGEON", stacktrace: stackTrace));
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
