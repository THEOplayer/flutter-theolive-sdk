import 'package:theolive/theolive.dart';

/// Internal Flutter representation of the underlying native THEOlive state.
class PlayerState implements THEOliveViewControllerEventListener {
  late THEOliveViewController _viewController;
  StateChangeListener? _stateChangeListener;

  bool isInitialized = false;

  // SourceDescription? source;
  // bool isAutoplay = false;
  bool isLoaded = false;
  bool isPaused = true;

  // double currentTime = 0.0;
  // DateTime? currentProgramDateTime;
  // double duration = 0.0;
  // double playbackRate = 0.0;
  // double volume = 1.0;
  // bool muted = false;
  // PreloadType preload = PreloadType.none;
  // ReadyState readyState = ReadyState.have_nothing;
  // bool isSeeking = false;
  // bool isEnded = false;
  // int videoWidth = 0;
  // int videoHeight = 0;
  // List<TimeRange?> buffered = [];
  // List<TimeRange?> seekable = [];
  // List<TimeRange?> played = [];
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
  void onChannelLoadStartEvent(String channelID) {
    _stateChangeListener?.call();
  }

  @override
  void onChannelLoadedEvent(String channelID) {
    _stateChangeListener?.call();
  }

  @override
  void onChannelOfflineEvent(String channelID) {
    _stateChangeListener?.call();
  }

  @override
  void onError(String message) {
    error = message;
    _stateChangeListener?.call();
  }

  @override
  void onIntentToFallback() {
    _stateChangeListener?.call();
  }

  @override
  void onPause() {
    isPaused = true;
    _stateChangeListener?.call();
  }

  @override
  void onPlay() {
    isPaused = false;
    _stateChangeListener?.call();
  }

  @override
  void onPlaying() {
    isLoaded = true;
    _stateChangeListener?.call();
  }

  @override
  void onReset() {
    _stateChangeListener?.call();
  }

  @override
  void onWaiting() {
    _stateChangeListener?.call();
  }

  /// Method to reset the player state.
  void resetState() {
    // source = null;
    isLoaded = false;
    isPaused = true;
    // currentTime = 0.0;
    // currentProgramDateTime = null;
    // duration = 0.0;
    // volume = 1.0;
    // readyState = ReadyState.have_nothing;
    // isSeeking = false;
    // isEnded = false;
    // videoWidth = 0;
    // videoHeight = 0;
    // buffered = [];
    // seekable = [];
    // played = [];
    error = null;
  }

  /// Method to clean the internal state on player dispose.
  void dispose() {
    (_viewController as THEOliveViewControllerMobile).eventListener = null;
    isInitialized = false;
    resetState();
  }
}
