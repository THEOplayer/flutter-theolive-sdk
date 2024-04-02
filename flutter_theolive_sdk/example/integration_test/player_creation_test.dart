import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../integration_test_app/test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test player creation', (WidgetTester tester) async {
    TestApp app = TestApp();
    await tester.pumpWidget(app);

    final chromlessPlayerView = find.byKey(const Key('testChromelessPlayer'));
    await tester.ensureVisible(chromlessPlayerView);
    final player = (tester.firstElement(chromlessPlayerView).widget as ChromelessPlayer).player;

    await tester.pumpAndSettle();
    await app.waitForPlayerReady();

    expect(player.isInitialized(), isTrue, reason: "Testing isInitialized()");
    expect(player.isPaused(), isTrue, reason: "Testing isPaused()");
  });
}