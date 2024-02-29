import 'package:flutter/material.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:theolive_platform_interface/theolive_playerconfig.dart';
import 'package:theolive_platform_interface/theolive_view_controller_interface.dart';

typedef THEOliveViewCreatedCallback = void Function(THEOliveViewController controller);

abstract class TheolivePlatform extends PlatformInterface {
  /// Constructs a TheolivePlatform.
  TheolivePlatform() : super(token: _token);

  static final Object _token = Object();

  static TheolivePlatform _instance = NotImplementedTHEOlivePlatform();

  /// The default instance of [TheolivePlatform] to use.
  ///
  /// Defaults to [MethodChannelTheolive].
  static TheolivePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TheolivePlatform] when
  /// they register themselves.
  static set instance(TheolivePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Widget buildView(BuildContext context,PlayerConfig playerConfig, THEOliveViewCreatedCallback createdCallback) {
    throw UnimplementedError('buildView(BuildContext) has not been implemented.');
  }
}

class NotImplementedTHEOlivePlatform extends TheolivePlatform {}