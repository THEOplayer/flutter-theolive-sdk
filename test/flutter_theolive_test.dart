import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_theolive/flutter_theolive.dart';
import 'package:flutter_theolive/flutter_theolive_platform_interface.dart';
import 'package:flutter_theolive/flutter_theolive_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterTheolivePlatform
    with MockPlatformInterfaceMixin
    implements FlutterTheolivePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterTheolivePlatform initialPlatform = FlutterTheolivePlatform.instance;

  test('$MethodChannelFlutterTheolive is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterTheolive>());
  });

  test('getPlatformVersion', () async {
    FlutterTheolive flutterTheolivePlugin = FlutterTheolive();
    MockFlutterTheolivePlatform fakePlatform = MockFlutterTheolivePlatform();
    FlutterTheolivePlatform.instance = fakePlatform;

    expect(await flutterTheolivePlugin.getPlatformVersion(), '42');
  });
}
