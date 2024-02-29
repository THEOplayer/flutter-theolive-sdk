import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_theolive_platform_interface.dart';

/// An implementation of [FlutterTheolivePlatform] that uses method channels.
class MethodChannelFlutterTheolive extends FlutterTheolivePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_theolive');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
