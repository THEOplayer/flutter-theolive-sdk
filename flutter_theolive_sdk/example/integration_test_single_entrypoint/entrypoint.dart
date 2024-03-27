import '../integration_test/plugin_integration_test.dart' as plugin_tests;

// entry point for web integration tests to run them with `flutter drive`
// entry point for iOS tests, becuase the simulator is sensitive to start test multiple times
// can not be used on Android, because the emulator is sensitive to this... (TODO: investigate this further)
void main() {
  plugin_tests.main();
}