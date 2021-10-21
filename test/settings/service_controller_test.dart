import 'package:asistanto/src/app.dart';
import 'package:asistanto/src/settings/settings_service.dart';
import 'package:asistanto/src/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeSettingsService with SettingsService {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Future<ThemeMode> themeMode() async => _themeMode;

  @override
  Future<void> updateThemeMode(ThemeMode theme) async {
    _themeMode = theme;
  }
}

void main() {
  group("ServiceController.updateThemeMode should", () {
    test('inform the service of the value', () async {
      final service = FakeSettingsService();
      final controller = SettingsController(service);
      await controller.loadSettings();
      await controller.updateThemeMode(ThemeMode.dark);

      expect(controller.themeMode, ThemeMode.dark);
      expect(service._themeMode, ThemeMode.dark);
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
