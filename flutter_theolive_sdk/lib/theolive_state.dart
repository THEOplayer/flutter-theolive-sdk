import 'package:theolive/theolive.dart';

/// Internal Flutter representation of the underlying native THEOlive state.
class PlayerState implements THEOliveViewControllerEventListener {
  late THEOliveViewController _viewController;
  StateChangeListener? _stateChangeListener;

  ChannelState channelState = ChannelState.idle;
  bool isInitialized = false;
  bool isAutoplay = false;
  bool isLoaded = false;
  bool isPaused = true;
  bool muted = false;
  bool badNetworkMode = false;
  String? error;

  PlayerState() {
    resetState();
  }

  /// Method to setup the connection with the platform-specific [THEOliveViewController] classes.
  void setViewController(THEOliveViewController viewController) {
    _viewController = viewController;
    (_viewController as THEOliveViewControllerMobile).eventListener = this;
  }

  /// Use it signal that the native player creation is done.
  void initialized() {
    isInitialized = true;
    _stateChangeListener?.call();
  }

  /// Sets a [StateChangeListener] that gets triggered on every state change.
  void setStateListener(StateChangeListener listener) {
    _stateChangeListener = listener;
  }

  @override
  void onChannelLoadStart(String channelID) {
    channelState = ChannelState.loading;
    _stateChangeListener?.call();
  }

  @override
  void onChannelLoaded(String channelID) {
    _viewController.isAutoplay().then((value) => {isAutoplay = value});
    channelState = ChannelState.loaded;
    isLoaded = true;
    _stateChangeListener?.call();
  }

  @override
  void onChannelOffline(String channelID) {
    channelState = ChannelState.offline;
    _stateChangeListener?.call();
  }

  @override
  void onWaiting() {
    _stateChangeListener?.call();
  }

  @override
  void onPlay() {
    isPaused = false;
    _stateChangeListener?.call();
  }

  @override
  void onPlaying() {
    _stateChangeListener?.call();
  }

  @override
  void onPause() {
    isPaused = true;
    _stateChangeListener?.call();
  }

  @override
  void onMutedChange() {
    _stateChangeListener?.call();
  }

  @override
  void onIntentToFallback() {
    _stateChangeListener?.call();
  }

  @override
  void onEnterBadNetworkMode() {
    badNetworkMode = true;
    _stateChangeListener?.call();
  }

  @override
  void onExitBadNetworkMode() {
    badNetworkMode = false;
    _stateChangeListener?.call();
  }

  @override
  void onReset() {
    resetState();
    _stateChangeListener?.call();
  }

  @override
  void onError(String message) {
    error = message;
    _stateChangeListener?.call();
  }

  /// Method to reset the player state.
  void resetState() {
    channelState = ChannelState.idle;
    isAutoplay = false;
    isLoaded = false;
    isPaused = true;
    muted = false;
    badNetworkMode = false;
    error = null;
  }

  /// Method to clean the internal state on player dispose.
  void dispose() {
    (_viewController as THEOliveViewControllerMobile).eventListener = null;
    isInitialized = false;
    resetState();
  }
}
