import 'package:asistanto/src/app.dart';
import 'package:asistanto/src/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_settings_service.dart';

void main() {
  group("ServiceController.updateThemeMode should", () {
    test('inform the service of the value', () async {
      final service = FakeSettingsService();
      final controller = SettingsController(service);
      await controller.loadSettings();

      expect(controller.themeMode, ThemeMode.system);
      expect(await service.themeMode(), ThemeMode.system);

      await controller.updateThemeMode(ThemeMode.dark);
      expect(controller.themeMode, ThemeMode.dark);
      expect(await service.themeMode(), ThemeMode.dark);
    });

    testWidgets('inform the UI of the value', (WidgetTester tester) async {
      final controller = SettingsController(FakeSettingsService());
      await controller.loadSettings();
      final myApp = MyApp(settingsController: controller);

      await tester.pumpWidget(myApp);

      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
        ThemeMode.system,
      );

      await controller.updateThemeMode(ThemeMode.dark);

      await tester.pumpWidget(myApp);

      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
        ThemeMode.dark,
      );
    });
  });
}
