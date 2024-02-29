import 'flutter_theolive_platform_interface.dart';

export 'package:theolive_platform_interface/theolive_view_controller_interface.dart';
export 'package:theolive_platform_interface/theolive_playerconfig.dart';
export 'package:theolive_platform_interface/theolive_viewcontroller_mobile.dart';

class FlutterTheolive {
  Future<String?> getPlatformVersion() {
    return FlutterTheolivePlatform.instance.getPlatformVersion();
  }
}