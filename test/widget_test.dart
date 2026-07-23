import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:digital_tasbeeh/core/constants/app_constants.dart';
import 'package:digital_tasbeeh/core/di/injection.dart';
import 'package:digital_tasbeeh/features/tasbeeh/cubit/tasbeeh_cubit.dart';
import 'package:digital_tasbeeh/features/tasbeeh/cubit/tasbeeh_state.dart';
import 'package:digital_tasbeeh/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await sl.reset();
    await initDependencies();
  });

  group('TasbeehCubit', () {
    test('loadCount emits loaded state with saved value', () async {
      SharedPreferences.setMockInitialValues({
        AppConstants.tasbeehCountKey: 7,
      });
      await sl.reset();
      await initDependencies();

      final cubit = sl<TasbeehCubit>();
      await cubit.loadCount();

      expect(cubit.state, isA<TasbeehLoaded>());
      expect((cubit.state as TasbeehLoaded).count, 7);
      await cubit.close();
    });

    test('increment increases count and persists value', () async {
      final cubit = sl<TasbeehCubit>();
      await cubit.loadCount();
      await cubit.increment();

      expect((cubit.state as TasbeehLoaded).count, 1);
      expect(
        sl<SharedPreferences>().getInt(AppConstants.tasbeehCountKey),
        1,
      );
      await cubit.close();
    });

    test('reset returns count to zero', () async {
      SharedPreferences.setMockInitialValues({
        AppConstants.tasbeehCountKey: 12,
      });
      await sl.reset();
      await initDependencies();

      final cubit = sl<TasbeehCubit>();
      await cubit.loadCount();
      await cubit.reset();

      expect((cubit.state as TasbeehLoaded).count, 0);
      await cubit.close();
    });
  });

  testWidgets('app renders counter and tap button', (tester) async {
    await tester.pumpWidget(const DigitalTasbeehApp());
    await tester.pumpAndSettle();

    expect(find.text(AppConstants.appName), findsOneWidget);
    expect(find.text('Tap'), findsOneWidget);
    expect(find.text('Reset'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.text('Tap'));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget);
  });
}
