import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:theolive/theolive.dart';

import '../integration_test_app/test_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test basic playback', (WidgetTester tester) async {
    TestApp app = TestApp();
    await tester.pumpWidget(app);

    final chromlessPlayerView = find.byKey(const Key('testChromelessPlayer'));
    await tester.ensureVisible(chromlessPlayerView);
    final player = (tester.firstElement(chromlessPlayerView).widget as ChromelessPlayer).player;

    await app.waitForPlayerReady();

    print("Testing isInitialized()");
    expect(player.isInitialized(), isTrue);

    print("Testing isPaused()");
    expect(player.isPaused(), isTrue);

    print("Setting source");

    player.loadChannel("2vqqekesftg9zuvxu9tdme6kl");
    await tester.pumpAndSettle();
    player.play();
    await tester.pumpAndSettle();

    await tester.pumpAndSettle(const Duration(seconds: 10));

    print("Testing channel state :  ${player.state()}");
    expect(player.state() == ChannelState.loaded, isTrue);

    print("Testing isPaused :  ${player.isPaused()}");
    expect(player.isPaused(), isFalse);
  });
}