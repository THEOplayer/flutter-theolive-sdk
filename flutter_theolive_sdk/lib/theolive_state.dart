import 'package:theolive/theolive.dart';
import 'package:theolive_platform_interface/theolive_view_controller_interface.dart';

/// Internal Flutter representation of the underlying native THEOlive state.
class PlayerState implements THEOliveEventListener {
  final List<THEOliveEventListener> _eventListeners = [];
  late THEOliveViewController _viewController;
  StateChangeListener? _stateChangeListener;

  ChannelState channelState = ChannelState.idle;
  bool isInitialized = false;
  bool isPaused = true;
  bool isWaiting = false;
  bool isAutoplay = false;
  bool muted = false;
  bool badNetworkMode = false;
  String? error;

  PlayerState() {
    resetState();
  }

  /// Method to setup the connection with the platform-specific [THEOliveViewController] classes.
  void setViewController(THEOliveViewController viewController) {
    _viewController = viewController;
    _viewController.setEventListener(this);
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

  /// Add a [THEOliveEventListener] that triggers on specific state change.
  void addEventListener(THEOliveEventListener eventListener) {
    _eventListeners.add(eventListener);
  }

  /// Remove a [THEOliveEventListener] that triggers on specific state change.
  void removeEventListener(THEOliveEventListener eventListener) {
    _eventListeners.remove(eventListener);
  }

  @override
  void onChannelLoadStart(String channelID) {
    channelState = ChannelState.loading;
    _stateChangeListener?.call();
    _eventListeners.forEach((listener) {
      listener.onChannelLoadStart(channelID);
    });
  }

  @override
  void onChannelLoaded(String channelID) {
    _viewController.isAutoplay().then((value) {
      channelState = ChannelState.loaded;
      isAutoplay = value;
      _stateChangeListener?.call();
      _eventListeners.forEach((listener) {
        listener.onChannelLoaded(channelID);
      });
    });
  }

  @override
  void onChannelOffline(String channelID) {
    channelState = ChannelState.offline;
    _stateChangeListener?.call();
    _eventListeners.forEach((listener) {
      listener.onChannelOffline(channelID);
    });
  }

  @override
  void onWaiting() {
    isWaiting = true;
    _stateChangeListener?.call();
    _eventListeners.forEach((listener) {
      listener.onWaiting();
    });
  }

  @override
  void onPlay() {
    isPaused = false;
    _stateChangeListener?.call();
    _eventListeners.forEach((listener) {
      listener.onPlay();
    });
  }

  @override
  void onPlaying() {
    isWaiting = false;
    _stateChangeListener?.call();
    _eventListeners.forEach((listener) {
      listener.onPlaying();
    });
  }

  @override
  void onPause() {
    isPaused = true;
    _stateChangeListener?.call();
    _eventListeners.forEach((listener) {
      listener.onPause();
    });
  }

  @override
  void onMutedChange() {
    _stateChangeListener?.call();
    _eventListeners.forEach((listener) {
      listener.onMutedChange();
    });
  }

  @override
  void onIntentToFallback() {
    channelState = ChannelState.intentToFallback;
    _stateChangeListener?.call();
    _eventListeners.forEach((listener) {
      listener.onIntentToFallback();
    });
  }

  @override
  void onEnterBadNetworkMode() {
    badNetworkMode = true;
    _stateChangeListener?.call();
    _eventListeners.forEach((listener) {
      listener.onEnterBadNetworkMode();
    });
  }

  @override
  void onExitBadNetworkMode() {
    badNetworkMode = false;
    _stateChangeListener?.call();
    _eventListeners.forEach((listener) {
      listener.onExitBadNetworkMode();
    });
  }

  @override
  void onReset() {
    resetState();
    _stateChangeListener?.call();
    _eventListeners.forEach((listener) {
      listener.onReset();
    });
  }

  @override
  void onError(String message) {
    error = message;
    _stateChangeListener?.call();
    _eventListeners.forEach((listener) {
      listener.onError(message);
    });
  }

  /// Method to reset the player state.
  void resetState() {
    channelState = ChannelState.idle;
    isPaused = true;
    isWaiting = false;
    isAutoplay = false;
    muted = false;
    badNetworkMode = false;
    error = null;
  }

  /// Method to clean the internal state on player dispose.
  void dispose() {
    _viewController.setEventListener(null);
    isInitialized = false;
    resetState();
  }
}
