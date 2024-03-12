//TODO: make it a pigeon?

/// Experimental API to allow using different Flutter renderings on Android, and use different renderingTarget in THEOlive player.
class PlayerConfig {
  AndroidConfig androidConfig = AndroidConfig();

  PlayerConfig(this.androidConfig);
}

class AndroidConfig {
  bool useHybridComposition;
  AndroidNativeRenderingTarget nativeRenderingTarget;

  AndroidConfig({this.useHybridComposition = true, this.nativeRenderingTarget = AndroidNativeRenderingTarget.surfaceView});
}

enum AndroidNativeRenderingTarget {
  surfaceView,
  textureView,
  //surfaceTexture
}

class NativePlayerConfiguration {
  String? sessionId;
}

enum ChannelState {
  idle,
  loading,
  loaded,
  offline
}
