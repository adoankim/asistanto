import 'package:asistanto/src/settings/settings_controller.dart';
import 'package:asistanto/src/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_settings_service.dart';

void main() {
  group('SettingsView test', () {
    testWidgets('Testing the SettingsView drop down',
        (WidgetTester tester) async {
      final service = FakeSettingsService();
      final controller = SettingsController(service);
      await controller.loadSettings();

      final settings = SettingsView(controller: controller);

      // gets the flutter test environment into a fake flutter runtime anb fully
      // hydrate this widget.
      await tester.pumpWidget(MaterialApp(home: settings));

      expect(find.byKey(const Key('settings_dropdown')), findsOneWidget);

      await tester.tap(find.byKey(const Key('settings_dropdown')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Dark Theme').last);
      await tester.pumpAndSettle();

      expect(controller.themeMode, ThemeMode.dark);
    });
  });
}
