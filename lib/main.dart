import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_constants.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'features/tasbeeh/cubit/tasbeeh_cubit.dart';
import 'features/tasbeeh/presentation/pages/tasbeeh_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(const DigitalTasbeehApp());
}

class DigitalTasbeehApp extends StatelessWidget {
  const DigitalTasbeehApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TasbeehCubit>(),
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const TasbeehPage(),
      ),
    );
  }
}
