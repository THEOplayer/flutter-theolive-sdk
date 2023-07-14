import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_theolive_method_channel.dart';

abstract class FlutterTheolivePlatform extends PlatformInterface {
  /// Constructs a FlutterTheolivePlatform.
  FlutterTheolivePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterTheolivePlatform _instance = MethodChannelFlutterTheolive();

  /// The default instance of [FlutterTheolivePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterTheolive].
  static FlutterTheolivePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterTheolivePlatform] when
  /// they register themselves.
  static set instance(FlutterTheolivePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
