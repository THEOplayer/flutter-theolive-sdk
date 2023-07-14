
import 'flutter_theolive_platform_interface.dart';

class FlutterTheolive {
  Future<String?> getPlatformVersion() {
    return FlutterTheolivePlatform.instance.getPlatformVersion();
  }
}
